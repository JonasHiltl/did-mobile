import 'dart:convert';
import 'package:did/data/common_backend_repo.dart';
import 'package:did/data/secure_storage.dart';
import 'package:did/models/did/identity.dart';
import 'package:did/models/patient_questionnaire/patient_questionnaire.dart';
import 'package:did/models/personal_data_vc/personal_data_vc.dart';
import 'package:did/models/received_patient_questionnaire/received_patient_questionnaire.dart';
import 'package:did/providers/app_settings/app_settings_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

import 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit(
    this.commonBackendRepo, {
    required this.appSettingsBloc,
  }) : super(
          UnkownSessionState(),
        ) {
    attemptGettingSavedState();
  }

  final CommonBackendRepo commonBackendRepo;
  final SecureStorage secureStorage = SecureStorage();
  final _auth = LocalAuthentication();
  final AppSettingsBloc appSettingsBloc;

  Future<bool> hasBiometric() async {
    try {
      final isDeviceSupported = await _auth.isDeviceSupported();
      final isAvailable = await _auth.canCheckBiometrics;
      return isAvailable && isDeviceSupported;
    } on PlatformException catch (e) {
      print("hasBiometric Error $e");
      return false;
    }
  }

  Future<bool> authenticate() async {
    try {
      return await _auth.authenticate(
        localizedReason: "Scan Fingerprint to Authenticate",
        stickyAuth: true,
        androidAuthStrings: const AndroidAuthMessages(
          biometricHint: "",
        ),
      );
    } on PlatformException catch (e) {
      print("Authentication Error: $e");
      return false;
    }
  }

  Future<Identity> getdid() async {
    final encodedDid = await secureStorage.read("identity");
    final decodedDid = jsonDecode(
      encodedDid.toString(),
    ) as Map<String, dynamic>;
    return Identity.fromJson(decodedDid);
  }

  Future<PersonalDataVc> getPersonalDataVc() async {
    final encodedPersonalDataVc = await secureStorage.read("personal_data_vc");
    final decodedPersonalDataVc = jsonDecode(
      encodedPersonalDataVc.toString(),
    ) as Map<String, dynamic>;
    return PersonalDataVc.fromJson(decodedPersonalDataVc);
  }

  Future<List<PatientQuestionnaireVc>> getListPQ() async {
    final encodedPQ = await secureStorage.read("patient_questionnaire");
    final decodedPQ = jsonDecode(
      encodedPQ.toString(),
    ) as List<dynamic>;

    // convert saved list of patient questionnaires to List<PatientQuestionnaireVc>
    final List<PatientQuestionnaireVc> listPQ = [];
    decodedPQ.map((e) {
      listPQ.add(
        PatientQuestionnaireVc.fromJson(e as Map<String, dynamic>),
      );
    }).toList();

    return listPQ;
  }

  Future<List<ReceivedPatientQuestionnaire>> getListReceivedPQ() async {
    final encodedDocuments =
        await secureStorage.read("received_patient_questionnaires");
    final decodedDocuments = jsonDecode(
      encodedDocuments.toString(),
    ) as List<dynamic>;

    // convert saved list of patient questionnaires to List<PatientQuestionnaireVc>
    final List<ReceivedPatientQuestionnaire> listSharedPQ = [];
    decodedDocuments.map((e) {
      listSharedPQ.add(
        ReceivedPatientQuestionnaire.fromJson(e as Map<String, dynamic>),
      );
    }).toList();
    return listSharedPQ;
  }

  Future<void> attemptGettingSavedState() async {
    try {
      if (await secureStorage.contains("identity") &&
          await secureStorage.contains("personal_data_vc")) {
        final identity = await getdid();
        final personalDataVc = await getPersonalDataVc();

        List<PatientQuestionnaireVc> listPQ = [];
        if (await secureStorage.contains("patient_questionnaire")) {
          listPQ = await getListPQ();
        }

        List<ReceivedPatientQuestionnaire> listSharedPQ = [];
        if (await secureStorage.contains("received_patient_questionnaires")) {
          listSharedPQ = await getListReceivedPQ();
        }

        if (await commonBackendRepo.verifyDid(identity.doc.id)) {
          if (appSettingsBloc.state.useTouchID && await hasBiometric()) {
            final isAuthenticated = await authenticate();

            if (isAuthenticated) {
              emit(
                Verified(
                  identity: identity,
                  personalDataVc: personalDataVc,
                  patientQuestionnaires: listPQ,
                  receivedPatientQuestionnaires: listSharedPQ,
                ),
              );
            }
          } else {
            print("no TOuch ID");
            emit(
              Verified(
                identity: identity,
                personalDataVc: personalDataVc,
                patientQuestionnaires: listPQ,
                receivedPatientQuestionnaires: listSharedPQ,
              ),
            );
          }
        } else {
          emit(
            Unverified(),
          );
        }
      } else {
        emit(
          Unverified(),
        );
      }
    } catch (e) {
      print("Sessioncubit error: $e");
      emit(
        Unverified(),
      );
    }
  }

  void showUnverified() => emit(
        Unverified(),
      );

  void showSession(Identity identity, PersonalDataVc personalDataVc) {
    emit(
      Verified(identity: identity, personalDataVc: personalDataVc),
    );
  }

  void startSessionWithVerifiedStateObj(Verified verified) {
    emit(
      Verified(
        identity: verified.identity,
        personalDataVc: verified.personalDataVc,
        patientQuestionnaires: verified.patientQuestionnaires,
        receivedPatientQuestionnaires: verified.receivedPatientQuestionnaires,
      ),
    );
  }

  Future<void> deleteAll() async {
    await secureStorage.deleteAll();
    emit(
      Unverified(),
    );
  }

  Future<void> deletePQ(int index, Verified verified) async {
    final listPQ = verified.patientQuestionnaires;

    listPQ.removeAt(index);

    secureStorage.write(
      "patient_questionnaire",
      jsonEncode(listPQ),
    );

    emit(
      Verified(
        identity: verified.identity,
        personalDataVc: verified.personalDataVc,
        patientQuestionnaires: listPQ,
        receivedPatientQuestionnaires: verified.receivedPatientQuestionnaires,
      ),
    );
  }

  Future<void> deleteReceivedPQ(int index, Verified verified) async {
    final listReceivedPQ = verified.receivedPatientQuestionnaires;

    listReceivedPQ.removeAt(index);

    secureStorage.write(
        "received_patient_questionnaires", jsonEncode(listReceivedPQ));

    emit(
      Verified(
        identity: verified.identity,
        personalDataVc: verified.personalDataVc,
        patientQuestionnaires: verified.patientQuestionnaires,
        receivedPatientQuestionnaires: listReceivedPQ,
      ),
    );
  }
}
