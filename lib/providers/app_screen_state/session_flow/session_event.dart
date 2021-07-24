import 'package:did/models/did/identity.dart';
import 'package:did/models/patient_questionnaire/patient_questionnaire.dart';
import 'package:did/models/personal_data_vc/personal_data_vc.dart';
import 'package:did/models/received_patient_questionnaire/received_patient_questionnaire.dart';

abstract class SessionEvent {}

class DeletePQ extends SessionEvent {
  final int index;

  DeletePQ({required this.index});
}

class DeleteReceivedPQ extends SessionEvent {
  final int index;

  DeleteReceivedPQ({required this.index});
}

class AttemptGettingSavedState extends SessionEvent {}

class DeleteAll extends SessionEvent {}

class LaunchSession extends SessionEvent {
  final Identity identity;
  final PersonalDataVc personalDataVc;

  LaunchSession({
    required this.identity,
    required this.personalDataVc,
  });
}

class ChangeIdentity extends SessionEvent {
  final Identity identity;

  ChangeIdentity({required this.identity});
}

class ChangePersonalDataVc extends SessionEvent {
  final PersonalDataVc personalDataVc;

  ChangePersonalDataVc({required this.personalDataVc});
}

class ChangePatientQuestionnaires extends SessionEvent {
  final List<PatientQuestionnaireVc> patientQuestionnaires;

  ChangePatientQuestionnaires({required this.patientQuestionnaires});
}

class ChangeReceivedPatientQuestionnaires extends SessionEvent {
  final List<ReceivedPatientQuestionnaire> receivedPatientQuestionnaires;

  ChangeReceivedPatientQuestionnaires(
      {required this.receivedPatientQuestionnaires});
}
