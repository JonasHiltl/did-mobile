import 'package:did/models/allergy/allergy.dart';
import 'package:did/models/medication/medication.dart';
import 'package:did/providers/appScreenState/sessionFlow/sessionCubit.dart';
import 'package:did/providers/appScreenState/sessionFlow/sessionState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'create_PQ_event.dart';
import 'create_PQ_state.dart';
import 'formSubmissionStatus.dart';
import 'repo/create_pq_repo.dart';

class CreatePQBloc extends Bloc<CreatePQEvent, CreatePQState> {
  final CreatePQRepository repo;
  final Verified sessionState;
  CreatePQBloc({required this.repo, required this.sessionState})
      : super(CreatePQState(allergies: [], medications: []));

  @override
  Stream<CreatePQState> mapEventToState(CreatePQEvent event) async* {
    if (event is CreatePQAddAllergy) {
      final newState = state.allergies.add(event.allergy) as List<Allergy>?;
      yield state.copyWith(allergies: newState);
    } else if (event is CreatePQRemoveAllergy) {
      final List<Allergy> newState = List.from(state.allergies);
      newState.removeAt(event.index);
      yield state.copyWith(allergies: newState);
    } else if (event is CreatePQAddMedication) {
      final newState =
          state.medications.add(event.medication) as List<Medication>?;
      yield state.copyWith(medications: newState);
    } else if (event is CreatePQRemoveMedication) {
      final List<Medication> newState = List.from(state.medications);
      newState.removeAt(event.index);
      yield state.copyWith(medications: newState);
    } else if (event is CreatePQDocumentNameChanged) {
      yield state.copyWith(documentName: event.documentName);
    } else if (event is CreatePQResetDocumentName) {
      yield state.copyWith(documentName: "");
    } else if (event is CreatePQSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        final res = await repo.createPQ(
            sessionState.personalDataVc.credentialSubject.firstName,
            sessionState.personalDataVc.credentialSubject.lastName,
            sessionState.personalDataVc.credentialSubject.email,
            sessionState.personalDataVc.credentialSubject.phoneNumber,
            sessionState.personalDataVc.credentialSubject.dateOfBirth,
            sessionState.personalDataVc.credentialSubject.sex,
            sessionState.personalDataVc.credentialSubject.address.street,
            sessionState.personalDataVc.credentialSubject.address.city,
            sessionState.personalDataVc.credentialSubject.address.state,
            sessionState.personalDataVc.credentialSubject.address.postalCode,
            sessionState.personalDataVc.credentialSubject.address.country,
            state.documentName,
            state.allergies,
            state.medications);
        print(res);
        if (res.id.isNotEmpty) {
          yield state.copyWith(formStatus: SubmissionSuccess());
          yield state.copyWith(formStatus: const InitialFormStatus());

          print(res);
        } else {
          yield state.copyWith(
              formStatus: SubmissionFailed(
                  "Backend error creating patient questionnaire"));
          yield state.copyWith(formStatus: const InitialFormStatus());
        }
      } catch (e) {
        print(e);
        yield state.copyWith(formStatus: SubmissionFailed(e.toString()));
        yield state.copyWith(formStatus: const InitialFormStatus());
      }
    }
  }
}
