import 'package:json_annotation/json_annotation.dart';

part 'credential_subject.g.dart';

@JsonSerializable()
class CredentialSubject {
  final bool hasExpiration;

  CredentialSubject({
    required this.hasExpiration,
  });

  factory CredentialSubject.fromJson(Map<String, dynamic> data) =>
      _$CredentialSubjectFromJson(data);

  Map<String, dynamic> toJson() => _$CredentialSubjectToJson(this);
}
