import 'dart:convert';

import 'package:did/data/secure_storage.dart';
import 'package:did/models/allergy/allergy.dart';
import 'package:did/models/medication/medication.dart';
import 'package:did/models/patient_questionnaire/patient_questionnaire.dart';
import 'package:did/providers/app_screen_state/session_flow/session_cubit.dart';
import 'package:did/providers/app_screen_state/session_flow/session_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'create_PQ_event.dart';
import 'create_PQ_state.dart';
import 'form_submission_status.dart';
import 'repo/create_pq_repo.dart';

class CreatePQBloc extends Bloc<CreatePQEvent, CreatePQState> {
  final CreatePQRepository repo;
  final SessionCubit sessionCubit;
  final Verified sessionState;
  final SecureStorage secureStorage = SecureStorage();

  CreatePQBloc({
    required this.repo,
    required this.sessionState,
    required this.sessionCubit,
  }) : super(CreatePQState(allergies: [], medications: []));

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
            final encodedPQ = await secureStorage.read("patient_questionnaire");
            final decodedPQ = jsonDecode(encodedPQ.toString()) as List<dynamic>;

            // convert saved list of patient questionnaires to List<PatientQuestionnaireVc> and add newly created one
            final List<PatientQuestionnaireVc> listPQ = [];
            decodedPQ
                .map(
                  (e) => listPQ.add(
                    PatientQuestionnaireVc.fromJson(e as Map<String, dynamic>),
                  ),
                )
                .toList();
            listPQ.add(res);

            secureStorage.write("patient_questionnaire", jsonEncode(listPQ));

            final newSessionState =
                sessionState.copyWith(patientQuestionnaires: listPQ);
            sessionCubit.startSessionWithVerifiedStateObj(newSessionState);
          } else {
            // when no existing list of PQ's is present create list
            final newSessionState =
                sessionState.copyWith(patientQuestionnaires: [res]);
            await secureStorage.write(
                "patient_questionnaire", jsonEncode([res]));
            sessionCubit.startSessionWithVerifiedStateObj(newSessionState);
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
