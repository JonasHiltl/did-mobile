import 'package:json_annotation/json_annotation.dart';

import 'credential_subject.dart';
import 'proof.dart';

part 'access_vc.g.dart';

@JsonSerializable(explicitToJson: true)
class AccessVc {
  @JsonKey(name: "@context")
  final String context;
  final String id;
  final List<String> type;
  final CredentialSubject credentialSubject;
  final String issuer;
  final String issuanceDate;
  final String? expirationDate;
  final Proof proof;

  AccessVc({
    required this.context,
    required this.id,
    required this.type,
    required this.credentialSubject,
    required this.issuer,
    required this.issuanceDate,
    required this.expirationDate,
    required this.proof,
  });

  factory AccessVc.fromJson(Map<String, dynamic> data) =>
      _$AccessVcFromJson(data);

  Map<String, dynamic> toJson() => _$AccessVcToJson(this);
}
