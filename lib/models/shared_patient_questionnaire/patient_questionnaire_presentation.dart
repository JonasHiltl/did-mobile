import 'package:json_annotation/json_annotation.dart';
import 'verifiable_credential.dart';

part 'patient_questionnaire_presentation.g.dart';

@JsonSerializable(explicitToJson: true)
class PatientQuestionnairePresentation {
  @JsonKey(name: "@context")
  final String context;
  final String type;
  final VerifiableCredential verifiableCredential;
  final String holder;

  PatientQuestionnairePresentation({
    required this.context,
    required this.type,
    required this.verifiableCredential,
    required this.holder,
  });

  factory PatientQuestionnairePresentation.fromJson(
          Map<String, dynamic> data) =>
      _$PatientQuestionnairePresentationFromJson(data);

  Map<String, dynamic> toJson() =>
      _$PatientQuestionnairePresentationToJson(this);
}
