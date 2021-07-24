import 'package:did/models/allergy/allergy.dart';
import 'package:did/models/medication/medication.dart';
import 'package:json_annotation/json_annotation.dart';

import 'address.dart';

part 'credential_subject.g.dart';

@JsonSerializable(explicitToJson: true)
class CredentialSubject {
  CredentialSubject({
    required this.address,
    required this.dateOfBirth,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.sex,
    required this.documentName,
    required this.allergies,
    required this.medication,
  });

  final Address address;
  final DateTime dateOfBirth;
  final String email;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String sex;
  final String documentName;
  final List<Allergy> allergies;
  final List<Medication> medication;

  factory CredentialSubject.fromJson(Map<String, dynamic> data) =>
      _$CredentialSubjectFromJson(data);

  Map<String, dynamic> toJson() => _$CredentialSubjectToJson(this);
}
