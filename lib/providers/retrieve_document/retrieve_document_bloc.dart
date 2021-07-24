import 'dart:convert';

import 'package:did/data/secure_storage.dart';
import 'package:did/models/received_patient_questionnaire/received_patient_questionnaire.dart';
import 'package:did/providers/app_screen_state/session_flow/session_cubit.dart';
import 'package:did/providers/app_screen_state/session_flow/session_state.dart';
import 'package:did/providers/retrieve_document/repo/retrieve_document_repo.dart';
import 'package:did/providers/retrieve_document/retrieve_document_event.dart';
import 'package:did/providers/retrieve_document/retrieve_document_state.dart';
import 'package:did/providers/retrieve_document/retrieve_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RetrieveDocumentBloc
    extends Bloc<RetrieveDocumentEvent, RetrieveDocumentState> {
  final RetrieveDocumentRepo repo;
  final SessionCubit sessionCubit;
  final Verified sessionState;
  final SecureStorage secureStorage = SecureStorage();

  RetrieveDocumentBloc({
    required this.sessionCubit,
    required this.sessionState,
    required this.repo,
  }) : super(RetrieveDocumentState());

  @override
  Stream<RetrieveDocumentState> mapEventToState(
      RetrieveDocumentEvent event) async* {
    if (event is RetrieveDocument) {
      yield state.copyWith(retrieveStatus: Retrieving());
      try {
        final res = await repo.retrieve(state.annLink);
        if (res == null) {
          yield state.copyWith(
              retrieveStatus: RetrieveFailed("No Document returned!"));
          yield state.copyWith(retrieveStatus: const InitialRetrieveStatus());
          yield state.copyWith(annLink: "", othersPublicKey: "");
        } else if (res is ReceivedPatientQuestionnaire) {
          if (sessionState.receivedPatientQuestionnaires.isNotEmpty) {
            final documentsList = sessionState.receivedPatientQuestionnaires;
            documentsList.add(res);

            secureStorage.write(
              "received_patient_questionnaires",
              jsonEncode(documentsList),
            );

            final newSessionState = sessionState.copyWith(
                receivedPatientQuestionnaires: documentsList);
            sessionCubit.startSessionWithVerifiedStateObj(newSessionState);
          } else {
            final newSessionState =
                sessionState.copyWith(receivedPatientQuestionnaires: [res]);
            await secureStorage.write(
                "received_patient_questionnaires", jsonEncode([res]));
            sessionCubit.startSessionWithVerifiedStateObj(newSessionState);
          }
          yield state.copyWith(retrieveStatus: RetrieveSuccess());
          yield state.copyWith(retrieveStatus: const InitialRetrieveStatus());
          yield state.copyWith(annLink: "", othersPublicKey: "");
        }
      } catch (e) {
        print(e);
        yield state.copyWith(retrieveStatus: RetrieveFailed(e.toString()));
        yield state.copyWith(retrieveStatus: const InitialRetrieveStatus());
        yield state.copyWith(annLink: "", othersPublicKey: "");
      }
    }
    if (event is ChangeAnnLink) {
      yield state.copyWith(annLink: event.annLink);
    }
    if (event is ChangePublicKey) {
      yield state.copyWith(othersPublicKey: event.publicKey);
    }
  }
}
