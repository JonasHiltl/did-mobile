import 'package:did/models/allergy/allergy.dart';
import 'package:did/models/medication/medication.dart';

class CreatePQState {
  final List<Allergy> allergies;
  final List<Medication> medications;

  CreatePQState({
    required this.allergies,
    required this.medications,
  });

  CreatePQState copyWith(
      {List<Allergy>? allergies, List<Medication>? medications}) {
    return CreatePQState(
        allergies: allergies ?? this.allergies,
        medications: medications ?? this.medications);
  }
}
