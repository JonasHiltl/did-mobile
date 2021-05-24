import 'package:did/models/allergy/allergy.dart';
import 'package:did/models/medication/medication.dart';

abstract class CreatePQEvent {}

class CreatePQAddAllergy extends CreatePQEvent {
  final Allergy allergy;

  CreatePQAddAllergy({required this.allergy});
}

class CreatePQRemoveAllergy extends CreatePQEvent {
  final int index;

  CreatePQRemoveAllergy({required this.index});
}

class CreatePQAddMedication extends CreatePQEvent {
  final Medication medication;

  CreatePQAddMedication({required this.medication});
}

class CreatePQRemoveMedication extends CreatePQEvent {
  final int index;

  CreatePQRemoveMedication({required this.index});
}

class CreatePQDocumentNameChanged extends CreatePQEvent {
  final String documentName;

  CreatePQDocumentNameChanged({required this.documentName});
}

class CreatePQResetDocumentName extends CreatePQEvent {}

class CreatePQSubmitted extends CreatePQEvent {}
