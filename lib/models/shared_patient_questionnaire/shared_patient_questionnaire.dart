import 'package:did/models/access_vc/access_vc.dart';
import 'package:json_annotation/json_annotation.dart';

import './patient_questionnaire_presentation.dart';

part 'shared_patient_questionnaire.g.dart';

@JsonSerializable(explicitToJson: true)
class SharedPatientQuestionnaire {
  final PatientQuestionnairePresentation presentation;
  final AccessVc accessVc;

  SharedPatientQuestionnaire({
    required this.presentation,
    required this.accessVc,
  });

  factory SharedPatientQuestionnaire.fromJson(Map<String, dynamic> data) =>
      _$SharedPatientQuestionnaireFromJson(data);

  Map<String, dynamic> toJson() => _$SharedPatientQuestionnaireToJson(this);
}
