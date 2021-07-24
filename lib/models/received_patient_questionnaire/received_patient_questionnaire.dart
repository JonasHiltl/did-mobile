import 'package:did/models/access_vc/access_vc.dart';
import 'package:json_annotation/json_annotation.dart';

import './patient_questionnaire_presentation.dart';

part 'received_patient_questionnaire.g.dart';

@JsonSerializable(explicitToJson: true)
class ReceivedPatientQuestionnaire {
  final PatientQuestionnairePresentation presentation;
  final AccessVc accessVc;

  ReceivedPatientQuestionnaire({
    required this.presentation,
    required this.accessVc,
  });

  factory ReceivedPatientQuestionnaire.fromJson(Map<String, dynamic> data) =>
      _$ReceivedPatientQuestionnaireFromJson(data);

  Map<String, dynamic> toJson() => _$ReceivedPatientQuestionnaireToJson(this);
}
