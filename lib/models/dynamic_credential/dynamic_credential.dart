import 'package:did/models/patient_questionnaire/credential_subject.dart';
import 'package:json_annotation/json_annotation.dart';

import 'proof.dart';
part 'dynamic_credential.g.dart';

@JsonSerializable(explicitToJson: true)
class DynamicCredential {
  @JsonKey(name: "@context")
  final String context;
  final String id;
  final List<String> type;
  final CredentialSubject credentialSubject;
  final String issuer;
  final String issuanceDate;
  final Proof proof;

  DynamicCredential({
    required this.context,
    required this.id,
    required this.type,
    required this.credentialSubject,
    required this.issuer,
    required this.issuanceDate,
    required this.proof,
  });

  factory DynamicCredential.fromJson(Map<String, dynamic> data) =>
      _$DynamicCredentialFromJson(data);

  Map<String, dynamic> toJson() => _$DynamicCredentialToJson(this);
}
