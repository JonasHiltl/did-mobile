import 'dart:convert';
import 'package:did/data/commonBackendRepo.dart';
import 'package:did/data/secureStorage.dart';
import 'package:did/models/did/identity.dart';
import 'package:did/models/patient_questionnaire/patient_questionnaire.dart';
import 'package:did/models/personal_data_vc/personal_data_vc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sessionState.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit(this.commonBackendRepo) : super(UnkownSessionState()) {
    attemptGettingDid();
  }

  final CommonBackendRepo commonBackendRepo;
  final SecureStorage secureStorage = SecureStorage();

  Future<void> attemptGettingDid() async {
    try {
      //await secureStorage.delete("identity");
      if (await secureStorage.contains("identity") &&
          await secureStorage.contains("personal_data_vc")) {
        final encodedDid = await secureStorage.read("identity");
        final decodedDid =
            jsonDecode(encodedDid.toString()) as Map<String, dynamic>;
        final identity = Identity.fromJson(decodedDid);

        final encodedPersonalDataVc =
            await secureStorage.read("personal_data_vc");
        final decodedPersonalDataVc =
            jsonDecode(encodedPersonalDataVc.toString())
                as Map<String, dynamic>;
        final personalDataVc = PersonalDataVc.fromJson(decodedPersonalDataVc);

        // if patient questionnaire is already created launch session with these patient questionnaires
        if (await secureStorage.contains("patient_questionnaire")) {
          final encodedPQ = await secureStorage.read("patient_questionnaire");
          final decodedPQ = jsonDecode(encodedPQ.toString()) as List<dynamic>;

          //convert saved list of patient questionnaires to List<PatientQuestionnaireVc>
          final List<PatientQuestionnaireVc> listPQ = [];
          decodedPQ.map((e) {
            listPQ.add(
                PatientQuestionnaireVc.fromJson(e as Map<String, dynamic>));
          }).toList();

          if (await commonBackendRepo.verifyDid(identity.doc.id)) {
            emit(Verified(
                identity: identity,
                personalDataVc: personalDataVc,
                patientQuestionnaires: listPQ));
          } else {
            emit(Unverified());
          }
        } else {
          if (await commonBackendRepo.verifyDid(identity.doc.id)) {
            emit(Verified(identity: identity, personalDataVc: personalDataVc));
          } else {
            emit(Unverified());
          }
        }
      } else {
        emit(Unverified());
      }
    } catch (e) {
      print("Sessioncubit error: $e");
      emit(Unverified());
    }
  }

  Future<void> attemptGettingPatientQuestionnaire() async {
    try {
      if (await secureStorage.contains("patient_questionnaire")) {
        final encodedPQ = await secureStorage.read("patient_questionnaire");
        final decodedPQ = jsonDecode(encodedPQ.toString()) as List<dynamic>;

        //convert saved list of patient questionnaires to List<PatientQuestionnaireVc>
        final List<PatientQuestionnaireVc> listPQ = [];
        decodedPQ.map((e) {
          listPQ
              .add(PatientQuestionnaireVc.fromJson(e as Map<String, dynamic>));
        }).toList();
      }
    } catch (e) {
      print(e);
    }
  }

  void showUnverified() => emit(Unverified());
  void showSession(Identity identity, PersonalDataVc personalDataVc) {
    emit(Verified(identity: identity, personalDataVc: personalDataVc));
  }

  void startSessionWithVerifiedStateObj(Verified verified) {
    emit(Verified(
        identity: verified.identity,
        personalDataVc: verified.personalDataVc,
        patientQuestionnaires: verified.patientQuestionnaires));
  }

  Future<void> deleteAll() async {
    await secureStorage.deleteAll();
    emit(Unverified());
  }

  Future<void> deletePQ(int index, Verified verified) async {
    final encodedPQ = await secureStorage.read("patient_questionnaire");
    final decodedPQ = jsonDecode(encodedPQ.toString()) as List<dynamic>;

    final List<PatientQuestionnaireVc> listPQ = [];
    decodedPQ.map((e) {
      listPQ.add(PatientQuestionnaireVc.fromJson(e as Map<String, dynamic>));
    }).toList();

    listPQ.removeAt(index);

    secureStorage.write("patient_questionnaire", jsonEncode(listPQ));

    emit(Verified(
        identity: verified.identity,
        personalDataVc: verified.personalDataVc,
        patientQuestionnaires: listPQ));
  }
}
