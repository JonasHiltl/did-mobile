import 'package:json_annotation/json_annotation.dart';

part 'allergy.g.dart';

@JsonSerializable()
class Allergy {
  final String name;
  final String symptom;

  Allergy({
    required this.name,
    required this.symptom,
  });

  factory Allergy.fromJson(Map<String, dynamic> data) =>
      _$AllergyFromJson(data);

  Map<String, dynamic> toJson() => _$AllergyToJson(this);
}
