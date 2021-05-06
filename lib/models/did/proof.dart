import 'package:json_annotation/json_annotation.dart';

part 'proof.g.dart';

@JsonSerializable()
class Proof {
  Proof({
    required this.type,
    required this.verificationMethod,
    required this.signatureValue,
  });

  final String type;
  final String verificationMethod;
  final String signatureValue;

  factory Proof.fromJson(Map<String, dynamic> data) => _$ProofFromJson(data);

  Map<String, dynamic> toJson() => _$ProofToJson(this);
}
