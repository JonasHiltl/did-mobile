import 'package:did/models/did/identity.dart';
import 'package:did/models/patient_questionnaire/patient_questionnaire.dart';
import 'package:did/models/personal_data_vc/personal_data_vc.dart';

abstract class SessionState {}

class UnkownSessionState extends SessionState {}

class Unverified extends SessionState {}

class Verified extends SessionState {
  Verified({
    required this.identity,
    required this.personalDataVc,
    this.patientQuestionnaires = const [],
  });

  final Identity identity;
  final PersonalDataVc personalDataVc;
  List<PatientQuestionnaireVc> patientQuestionnaires;

  Verified copyWith({
    Identity? identity,
    PersonalDataVc? personalDataVc,
    List<PatientQuestionnaireVc>? patientQuestionnaires,
  }) {
    return Verified(
      identity: identity ?? this.identity,
      personalDataVc: personalDataVc ?? this.personalDataVc,
      patientQuestionnaires:
          patientQuestionnaires ?? this.patientQuestionnaires,
    );
  }
}
