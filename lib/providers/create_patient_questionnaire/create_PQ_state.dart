import 'package:did/models/allergy/allergy.dart';
import 'package:did/models/medication/medication.dart';
import 'form_submission_status.dart';

class CreatePQState {
  final List<Allergy> allergies;
  final List<Medication> medications;
  final String documentName;
  bool get isValidDocumentName => documentName.isNotEmpty;
  final FormSubmissionStatus formStatus;

  CreatePQState({
    required this.allergies,
    required this.medications,
    this.documentName = "",
    this.formStatus = const InitialFormStatus(),
  });

  CreatePQState copyWith({
    List<Allergy>? allergies,
    List<Medication>? medications,
    String? documentName,
    FormSubmissionStatus? formStatus,
  }) {
    return CreatePQState(
      allergies: allergies ?? this.allergies,
      medications: medications ?? this.medications,
      documentName: documentName ?? this.documentName,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
