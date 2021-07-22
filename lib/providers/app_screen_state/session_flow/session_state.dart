import 'package:did/models/did/identity.dart';
import 'package:did/models/patient_questionnaire/patient_questionnaire.dart';
import 'package:did/models/personal_data_vc/personal_data_vc.dart';
import 'package:did/models/shared_patient_questionnaire/shared_patient_questionnaire.dart';

abstract class SessionState {}

class UnkownSessionState extends SessionState {}

class Unverified extends SessionState {}

class Verified extends SessionState {
  Verified({
    required this.identity,
    required this.personalDataVc,
    this.patientQuestionnaires = const [],
    this.sharedPatientQuestionnaires = const [],
  });

  final Identity identity;
  final PersonalDataVc personalDataVc;
  List<PatientQuestionnaireVc> patientQuestionnaires;
  // SharedPatientQuestionnaire is first element in list of sharedDocuments
  List<SharedPatientQuestionnaire> sharedPatientQuestionnaires;

  Verified copyWith({
    Identity? identity,
    PersonalDataVc? personalDataVc,
    List<PatientQuestionnaireVc>? patientQuestionnaires,
    List<SharedPatientQuestionnaire>? sharedPatientQuestionnaires,
  }) {
    return Verified(
      identity: identity ?? this.identity,
      personalDataVc: personalDataVc ?? this.personalDataVc,
      patientQuestionnaires:
          patientQuestionnaires ?? this.patientQuestionnaires,
      sharedPatientQuestionnaires:
          sharedPatientQuestionnaires ?? this.sharedPatientQuestionnaires,
    );
  }
}
