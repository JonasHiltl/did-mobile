import 'dart:convert';

import 'package:did/data/secure_storage.dart';
import 'package:did/models/allergy/allergy.dart';
import 'package:did/models/medication/medication.dart';
import 'package:did/providers/app_screen_state/session_flow/session_bloc.dart';
import 'package:did/providers/app_screen_state/session_flow/session_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'create_PQ_event.dart';
import 'create_PQ_state.dart';
import 'form_submission_status.dart';
import 'repo/create_pq_repo.dart';

class CreatePQBloc extends Bloc<CreatePQEvent, CreatePQState> {
  final CreatePQRepository repo;
  final SessionBloc sessionBloc;
  final SecureStorage secureStorage = SecureStorage();

  CreatePQBloc({
    required this.repo,
    required this.sessionBloc,
  }) : super(
          CreatePQState(
            allergies: [],
            medications: [],
          ),
        );

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
          sessionBloc.state.personalDataVc!.credentialSubject.firstName,
          sessionBloc.state.personalDataVc!.credentialSubject.lastName,
          sessionBloc.state.personalDataVc!.credentialSubject.email,
          sessionBloc.state.personalDataVc!.credentialSubject.phoneNumber,
          sessionBloc.state.personalDataVc!.credentialSubject.dateOfBirth,
          sessionBloc.state.personalDataVc!.credentialSubject.sex,
          sessionBloc.state.personalDataVc!.credentialSubject.address.street,
          sessionBloc.state.personalDataVc!.credentialSubject.address.city,
          sessionBloc.state.personalDataVc!.credentialSubject.address.state,
          sessionBloc
              .state.personalDataVc!.credentialSubject.address.postalCode,
          sessionBloc.state.personalDataVc!.credentialSubject.address.country,
          state.documentName,
          state.allergies,
          state.medications,
        );
        if (res == null) {
          yield state.copyWith(
            formStatus: SubmissionFailed(
                "Backend error creating patient questionnaire"),
          );
          yield state.copyWith(formStatus: const InitialFormStatus());
          yield state
              .copyWith(medications: [], allergies: [], documentName: "");
        } else {
          // if list of PQ's already exist add new PQ
          if (await secureStorage.contains("patient_questionnaire")) {
            final listPQ = sessionBloc.state.patientQuestionnaires;
            listPQ.add(res);

            secureStorage.write("patient_questionnaire", jsonEncode(listPQ));

            sessionBloc.add(
              ChangePatientQuestionnaires(patientQuestionnaires: listPQ),
            );
          } else {
            // when no existing list of PQ's is present create list
            await secureStorage.write(
              "patient_questionnaire",
              jsonEncode([res]),
            );
            sessionBloc.add(
              ChangePatientQuestionnaires(
                patientQuestionnaires: [res],
              ),
            );
          }
          yield state.copyWith(formStatus: SubmissionSuccess());
          yield state.copyWith(formStatus: const InitialFormStatus());
          yield state
              .copyWith(medications: [], allergies: [], documentName: "");
        }
      } catch (e) {
        print(e);
        yield state.copyWith(formStatus: SubmissionFailed(e.toString()));
        yield state.copyWith(formStatus: const InitialFormStatus());
        yield state.copyWith(medications: [], allergies: [], documentName: "");
      }
    }
  }
}
