import 'package:json_annotation/json_annotation.dart';

import 'address.dart';

part 'credential_subject.g.dart';

@JsonSerializable(explicitToJson: true)
class CredentialSubject {
  CredentialSubject({
    required this.id,
    required this.address,
    required this.dateOfBirth,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.sex,
  });

  final String id;
  final Address address;
  final String dateOfBirth;
  final String email;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String sex;

  factory CredentialSubject.fromJson(Map<String, dynamic> data) =>
      _$CredentialSubjectFromJson(data);

  Map<String, dynamic> toJson() => _$CredentialSubjectToJson(this);
}
