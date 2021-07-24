import 'package:did/models/did/identity.dart';
import 'package:did/models/patient_questionnaire/patient_questionnaire.dart';
import 'package:did/models/personal_data_vc/personal_data_vc.dart';
import 'package:did/models/received_patient_questionnaire/received_patient_questionnaire.dart';

abstract class SessionState {}

class UnkownSessionState extends SessionState {}

class Unverified extends SessionState {}

class Verified extends SessionState {
  Verified({
    required this.identity,
    required this.personalDataVc,
    this.patientQuestionnaires = const [],
    this.receivedPatientQuestionnaires = const [],
  });

  final Identity identity;
  final PersonalDataVc personalDataVc;
  List<PatientQuestionnaireVc> patientQuestionnaires;
  // SharedPatientQuestionnaire is first element in list of sharedDocuments
  List<ReceivedPatientQuestionnaire> receivedPatientQuestionnaires;

  Verified copyWith({
    Identity? identity,
    PersonalDataVc? personalDataVc,
    List<PatientQuestionnaireVc>? patientQuestionnaires,
    List<ReceivedPatientQuestionnaire>? receivedPatientQuestionnaires,
  }) {
    return Verified(
      identity: identity ?? this.identity,
      personalDataVc: personalDataVc ?? this.personalDataVc,
      patientQuestionnaires:
          patientQuestionnaires ?? this.patientQuestionnaires,
      receivedPatientQuestionnaires:
          receivedPatientQuestionnaires ?? this.receivedPatientQuestionnaires,
    );
  }
}
