import 'package:json_annotation/json_annotation.dart';

import 'credential_subject.dart';
import 'proof.dart';

part 'credential.g.dart';

@JsonSerializable(explicitToJson: true)
class Credential {
  Credential({
    required this.context,
    required this.id,
    required this.type,
    required this.credentialSubject,
    required this.issuer,
    required this.issuanceDate,
    required this.proof,
  });

  @JsonKey(name: "@context")
  final String context;
  final String id;
  final List<String> type;
  final CredentialSubject credentialSubject;
  final String issuer;
  final String issuanceDate;
  final Proof proof;

  factory Credential.fromJson(Map<String, dynamic> data) =>
      _$CredentialFromJson(data);

  Map<String, dynamic> toJson() => _$CredentialToJson(this);
}
