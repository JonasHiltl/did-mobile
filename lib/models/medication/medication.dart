import 'package:json_annotation/json_annotation.dart';

part 'medication.g.dart';

@JsonSerializable()
class Medication {
  final String name;
  final String condition;
  final String frequency;
  final String dose;

  Medication({
    required this.name,
    required this.condition,
    required this.frequency,
    required this.dose,
  });

  factory Medication.fromJson(Map<String, dynamic> data) =>
      _$MedicationFromJson(data);

  Map<String, dynamic> toJson() => _$MedicationToJson(this);
}
