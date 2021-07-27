import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../allergy/allergy.dart';
import '../medication/medication.dart';
import 'address.dart';
import 'credential_subject.dart';
import 'proof.dart';

part 'patient_questionnaire.g.dart';

@JsonSerializable(explicitToJson: true)
class PatientQuestionnaireVc {
  PatientQuestionnaireVc({
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

  factory PatientQuestionnaireVc.fromDB(Map<String, dynamic> json) =>
      PatientQuestionnaireVc(
        context: json["context"] as String,
        id: json["id"] as String,
        type: jsonDecode(json["type"] as String) as List<String>,
        credentialSubject: CredentialSubject(
          address: Address(
            street: json["street"] as String,
            city: json["city"] as String,
            state: json["state"] as String,
            postalCode: json["postalCode"] as String,
            country: json["country"] as String,
          ),
          dateOfBirth: DateTime.parse(json["birth"] as String),
          email: json["email"] as String,
          firstName: json["first_name"] as String,
          lastName: json["last_name"] as String,
          phoneNumber: json["phone_number"] as String,
          sex: json["sex"] as String,
          documentName: json["document_name"] as String,
          allergies: (jsonDecode(json["allergies"] as String) as List<dynamic>)
              .map((e) => Allergy.fromJson(e as Map<String, dynamic>))
              .toList(),
          medication:
              (jsonDecode(json["medication"] as String) as List<dynamic>)
                  .map((e) => Medication.fromJson(e as Map<String, dynamic>))
                  .toList(),
        ),
        issuer: json["issuer"] as String,
        issuanceDate: json["issuance_date"] as String,
        proof: Proof(
            type: json["proof_type"] as String,
            verificationMethod: json["proof_verification_method"] as String,
            signatureValue: json["proof_signature_value"] as String),
      );

  Map<String, dynamic> toDB(PatientQuestionnaireVc instance) {
    return {
      "context": instance.context,
      "id": instance.id,
      "type": jsonEncode(
        instance.type,
      ),
      "document_name": instance.credentialSubject.documentName,
      "first_name": instance.credentialSubject.firstName,
      "last_name": instance.credentialSubject.lastName,
      "email": instance.credentialSubject.email,
      "phone_number": instance.credentialSubject.phoneNumber,
      "birth": instance.credentialSubject.dateOfBirth.toIso8601String(),
      "sex": instance.credentialSubject.sex,
      "street": instance.credentialSubject.address.street,
      "city": instance.credentialSubject.address.city,
      "state": instance.credentialSubject.address.state,
      "postal_code": instance.credentialSubject.address.postalCode,
      "country": instance.credentialSubject.address.country,
      "allergies": jsonEncode(
        instance.credentialSubject.allergies,
      ),
      "medication": jsonEncode(
        instance.credentialSubject.medication,
      ),
      "issuer": instance.issuer,
      "issuance_date": instance.issuanceDate,
      "proof_type": instance.proof.type,
      "proof_verification_method": instance.proof.verificationMethod,
      "proof_signature_value": instance.proof.signatureValue,
    };
  }

  factory PatientQuestionnaireVc.fromJson(Map<String, dynamic> data) =>
      _$PatientQuestionnaireVcFromJson(data);

  Map<String, dynamic> toJson() => _$PatientQuestionnaireVcToJson(this);
}
