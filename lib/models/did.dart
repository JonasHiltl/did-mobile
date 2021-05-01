import 'package:flutter/foundation.dart';

@immutable
class Did {
  const Did({
    required this.id,
    required this.docHash,
    required this.pubKey,
    required this.privKey,
    required this.credential,
    required this.message,
    required this.success,
  });

  factory Did.fromJson(Map<String, dynamic> json) => Did(
      id: json['id'] as String,
      docHash: json['docHash'] as String,
      pubKey: json['pubKey'] as String,
      privKey: json['privKey'] as String,
      credential:
          Credential.fromJson(json['credential'] as Map<String, dynamic>),
      message: json['message'] as String,
      success: json['success'] as bool);

  final String id;
  final String docHash;
  final String pubKey;
  final String privKey;
  final Credential credential;
  final String message;
  final bool success;

  Map<String, dynamic> toJson() => {
        'id': id,
        'docHash': docHash,
        'pubKey': pubKey,
        'privKey': privKey,
        'credential': credential.toJson(),
        'message': message,
        'success': success
      };

  Did clone() => Did(
      id: id,
      docHash: docHash,
      pubKey: pubKey,
      privKey: privKey,
      credential: credential.clone(),
      message: message,
      success: success);

  Did copyWith(
          {String? id,
          String? docHash,
          String? pubKey,
          String? privKey,
          Credential? credential,
          String? message,
          bool? success}) =>
      Did(
        id: id ?? this.id,
        docHash: docHash ?? this.docHash,
        pubKey: pubKey ?? this.pubKey,
        privKey: privKey ?? this.privKey,
        credential: credential ?? this.credential,
        message: message ?? this.message,
        success: success ?? this.success,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Did &&
          id == other.id &&
          docHash == other.docHash &&
          pubKey == other.pubKey &&
          privKey == other.privKey &&
          credential == other.credential &&
          message == other.message &&
          success == other.success;

  @override
  int get hashCode =>
      id.hashCode ^
      docHash.hashCode ^
      pubKey.hashCode ^
      privKey.hashCode ^
      credential.hashCode ^
      message.hashCode ^
      success.hashCode;
}

@immutable
class Credential {
  const Credential({
    required this.context,
    required this.id,
    required this.type,
    required this.credentialSubject,
    required this.issuer,
    required this.issuanceDate,
    required this.proof,
  });

  factory Credential.fromJson(Map<String, dynamic> json) => Credential(
      context: json['@context'] as String,
      id: json['id'] as String,
      type: (json['type'] as List<dynamic>).map((e) => e as String).toList(),
      credentialSubject: CredentialSubject.fromJson(
          json['credentialSubject'] as Map<String, dynamic>),
      issuer: json['issuer'] as String,
      issuanceDate: json['issuanceDate'] as String,
      proof: Proof.fromJson(json['proof'] as Map<String, dynamic>));

  final String context;
  final String id;
  final List<String> type;
  final CredentialSubject credentialSubject;
  final String issuer;
  final String issuanceDate;
  final Proof proof;

  Map<String, dynamic> toJson() => {
        'context': context,
        'id': id,
        'type': type,
        'credentialSubject': credentialSubject.toJson(),
        'issuer': issuer,
        'issuanceDate': issuanceDate,
        'proof': proof.toJson()
      };

  Credential clone() => Credential(
      context: context,
      id: id,
      type: type,
      credentialSubject: credentialSubject.clone(),
      issuer: issuer,
      issuanceDate: issuanceDate,
      proof: proof.clone());

  Credential copyWith(
          {String? context,
          String? id,
          List<String>? type,
          CredentialSubject? credentialSubject,
          String? issuer,
          String? issuanceDate,
          Proof? proof}) =>
      Credential(
        context: context ?? this.context,
        id: id ?? this.id,
        type: type ?? this.type,
        credentialSubject: credentialSubject ?? this.credentialSubject,
        issuer: issuer ?? this.issuer,
        issuanceDate: issuanceDate ?? this.issuanceDate,
        proof: proof ?? this.proof,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Credential &&
          context == other.context &&
          id == other.id &&
          type == other.type &&
          credentialSubject == other.credentialSubject &&
          issuer == other.issuer &&
          issuanceDate == other.issuanceDate &&
          proof == other.proof;

  @override
  int get hashCode =>
      context.hashCode ^
      id.hashCode ^
      type.hashCode ^
      credentialSubject.hashCode ^
      issuer.hashCode ^
      issuanceDate.hashCode ^
      proof.hashCode;
}

@immutable
class CredentialSubject {
  const CredentialSubject({
    required this.id,
    required this.address,
    required this.dateOfBirth,
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.sex,
  });

  factory CredentialSubject.fromJson(Map<String, dynamic> json) =>
      CredentialSubject(
          id: json['id'] as String,
          address: Address.fromJson(json['address'] as Map<String, dynamic>),
          dateOfBirth: json['dateOfBirth'] as String,
          email: json['email'] as String,
          name: Name.fromJson(json['name'] as Map<String, dynamic>),
          phoneNumber: json['phoneNumber'] as String,
          sex: json['sex'] as String);

  final String id;
  final Address address;
  final String dateOfBirth;
  final String email;
  final Name name;
  final String phoneNumber;
  final String sex;

  Map<String, dynamic> toJson() => {
        'id': id,
        'address': address.toJson(),
        'dateOfBirth': dateOfBirth,
        'email': email,
        'name': name.toJson(),
        'phoneNumber': phoneNumber,
        'sex': sex
      };

  CredentialSubject clone() => CredentialSubject(
      id: id,
      address: address.clone(),
      dateOfBirth: dateOfBirth,
      email: email,
      name: name.clone(),
      phoneNumber: phoneNumber,
      sex: sex);

  CredentialSubject copyWith(
          {String? id,
          Address? address,
          String? dateOfBirth,
          String? email,
          Name? name,
          String? phoneNumber,
          String? sex}) =>
      CredentialSubject(
        id: id ?? this.id,
        address: address ?? this.address,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        email: email ?? this.email,
        name: name ?? this.name,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        sex: sex ?? this.sex,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CredentialSubject &&
          id == other.id &&
          address == other.address &&
          dateOfBirth == other.dateOfBirth &&
          email == other.email &&
          name == other.name &&
          phoneNumber == other.phoneNumber &&
          sex == other.sex;

  @override
  int get hashCode =>
      id.hashCode ^
      address.hashCode ^
      dateOfBirth.hashCode ^
      email.hashCode ^
      name.hashCode ^
      phoneNumber.hashCode ^
      sex.hashCode;
}

@immutable
class Address {
  const Address({
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
      street: json['street'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      postalCode: json['postalCode'] as String,
      country: json['country'] as String);

  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;

  Map<String, dynamic> toJson() => {
        'street': street,
        'city': city,
        'state': state,
        'postalCode': postalCode,
        'country': country
      };

  Address clone() => Address(
      street: street,
      city: city,
      state: state,
      postalCode: postalCode,
      country: country);

  Address copyWith(
          {String? street,
          String? city,
          String? state,
          String? postalCode,
          String? country}) =>
      Address(
        street: street ?? this.street,
        city: city ?? this.city,
        state: state ?? this.state,
        postalCode: postalCode ?? this.postalCode,
        country: country ?? this.country,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Address &&
          street == other.street &&
          city == other.city &&
          state == other.state &&
          postalCode == other.postalCode &&
          country == other.country;

  @override
  int get hashCode =>
      street.hashCode ^
      city.hashCode ^
      state.hashCode ^
      postalCode.hashCode ^
      country.hashCode;
}

@immutable
class Name {
  const Name({
    required this.first,
    required this.last,
  });

  factory Name.fromJson(Map<String, dynamic> json) =>
      Name(first: json['first'] as String, last: json['last'] as String);

  final String first;
  final String last;

  Map<String, dynamic> toJson() => {'first': first, 'last': last};

  Name clone() => Name(first: first, last: last);

  Name copyWith({String? first, String? last}) => Name(
        first: first ?? this.first,
        last: last ?? this.last,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Name && first == other.first && last == other.last;

  @override
  int get hashCode => first.hashCode ^ last.hashCode;
}

@immutable
class Proof {
  const Proof({
    required this.type,
    required this.verificationMethod,
    required this.signatureValue,
  });

  factory Proof.fromJson(Map<String, dynamic> json) => Proof(
      type: json['type'] as String,
      verificationMethod: json['verificationMethod'] as String,
      signatureValue: json['signatureValue'] as String);

  final String type;
  final String verificationMethod;
  final String signatureValue;

  Map<String, dynamic> toJson() => {
        'type': type,
        'verificationMethod': verificationMethod,
        'signatureValue': signatureValue
      };

  Proof clone() => Proof(
      type: type,
      verificationMethod: verificationMethod,
      signatureValue: signatureValue);

  Proof copyWith(
          {String? type, String? verificationMethod, String? signatureValue}) =>
      Proof(
        type: type ?? this.type,
        verificationMethod: verificationMethod ?? this.verificationMethod,
        signatureValue: signatureValue ?? this.signatureValue,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Proof &&
          type == other.type &&
          verificationMethod == other.verificationMethod &&
          signatureValue == other.signatureValue;

  @override
  int get hashCode =>
      type.hashCode ^ verificationMethod.hashCode ^ signatureValue.hashCode;
}
