import 'dart:convert';

import 'package:did/data/secure_storage.dart';
import 'package:did/models/did/identity.dart';
import 'package:did/models/patient_questionnaire/patient_questionnaire.dart';
import 'package:did/models/personal_data_vc/personal_data_vc.dart';
import 'package:did/models/received_patient_questionnaire/received_patient_questionnaire.dart';
import 'package:did/providers/app_screen_state/session_flow/session_state.dart';
import 'package:did/providers/app_screen_state/session_flow/repo/session_repo.dart';
import 'package:did/providers/app_screen_state/session_flow/session_event.dart';
import 'package:did/providers/app_screen_state/session_flow/session_status.dart';
import 'package:did/providers/app_settings/app_settings_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  SessionBloc({
    required this.repo,
    required this.appSettingsState,
  }) : super(
          SessionState(),
        );

  final SessionRepo repo;
  final AppSettingsState appSettingsState;
  final SecureStorage secureStorage = SecureStorage();
  final _auth = LocalAuthentication();

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

  @override
  Stream<SessionState> mapEventToState(SessionEvent event) async* {
    if (event is DeletePQ) {
      final listPQ = state.patientQuestionnaires;
      listPQ.removeAt(event.index);
      yield state.copyWith(patientQuestionnaires: listPQ);

      secureStorage.write(
        "patient_questionnaire",
        jsonEncode(listPQ),
      );
    } else if (event is DeleteReceivedPQ) {
      final listReceivedPQ = state.receivedPatientQuestionnaires;
      listReceivedPQ.removeAt(event.index);
      yield state.copyWith(receivedPatientQuestionnaires: listReceivedPQ);

      secureStorage.write(
          "received_patient_questionnaires", jsonEncode(listReceivedPQ));
    } else if (event is DeleteAll) {
      await secureStorage.deleteAll();
      yield state.clear();
    } else if (event is LaunchSession) {
      yield state.copyWith(
          identity: event.identity,
          personalDataVc: event.personalDataVc,
          sessionStatus: Verified());
    } else if (event is ChangeIdentity) {
      yield state.copyWith(identity: event.identity);
    } else if (event is ChangePersonalDataVc) {
      yield state.copyWith(personalDataVc: event.personalDataVc);
    } else if (event is ChangePatientQuestionnaires) {
      yield state.copyWith(patientQuestionnaires: event.patientQuestionnaires);
    } else if (event is ChangeReceivedPatientQuestionnaires) {
      yield state.copyWith(
          receivedPatientQuestionnaires: event.receivedPatientQuestionnaires);
    } else if (event is AttemptGettingSavedState) {
      Future<Identity> getdid() async {
        final encodedDid = await secureStorage.read("identity");
        final decodedDid = jsonDecode(
          encodedDid.toString(),
        ) as Map<String, dynamic>;
        return Identity.fromJson(decodedDid);
      }

      Future<PersonalDataVc> getPersonalDataVc() async {
        final encodedPersonalDataVc =
            await secureStorage.read("personal_data_vc");
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

      try {
        if (await secureStorage.contains("identity") &&
            await secureStorage.contains("personal_data_vc")) {
          final identity = await getdid();
          final personalDataVc = await getPersonalDataVc();

          List<PatientQuestionnaireVc> listPQ = [];
          if (await secureStorage.contains("patient_questionnaire")) {
            listPQ = await getListPQ();
          }

          List<ReceivedPatientQuestionnaire> listReceivedPQ = [];
          if (await secureStorage.contains("received_patient_questionnaires")) {
            listReceivedPQ = await getListReceivedPQ();
          }

          if (await repo.verifyDid(identity.doc.id)) {
            if (appSettingsState.useTouchID && await hasBiometric()) {
              final isAuthenticated = await authenticate();

              if (isAuthenticated) {
                yield state.copyWith(
                  identity: identity,
                  personalDataVc: personalDataVc,
                  patientQuestionnaires: listPQ,
                  receivedPatientQuestionnaires: listReceivedPQ,
                );
                yield state.copyWith(sessionStatus: Verified());
              }
            } else {
              print("no TOuch ID");
              yield state.copyWith(
                identity: identity,
                personalDataVc: personalDataVc,
                patientQuestionnaires: listPQ,
                receivedPatientQuestionnaires: listReceivedPQ,
              );
              yield state.copyWith(sessionStatus: Verified());
            }
          } else {
            yield state.copyWith(sessionStatus: Unverified());
          }
        } else {
          yield state.copyWith(sessionStatus: Unverified());
        }
      } catch (e) {
        print("Sessioncubit error: $e");
        yield state.copyWith(sessionStatus: Unverified());
      }
    }
  }
}
