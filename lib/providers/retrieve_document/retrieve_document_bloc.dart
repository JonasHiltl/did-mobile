import 'dart:convert';

import 'package:did/data/secure_storage.dart';
import 'package:did/models/shared_patient_questionnaire/shared_patient_questionnaire.dart';
import 'package:did/providers/app_screen_state/session_flow/session_cubit.dart';
import 'package:did/providers/app_screen_state/session_flow/session_state.dart';
import 'package:did/providers/retrieve_document/repo/retrieve_document_repo.dart';
import 'package:did/providers/retrieve_document/retrieve_document_event.dart';
import 'package:did/providers/retrieve_document/retrieve_document_state.dart';
import 'package:did/providers/retrieve_document/retrieve_status.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void printWrapped(String text) {
  final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

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
        } else if (res is SharedPatientQuestionnaire) {
          if (await secureStorage.contains("shared_patient_questionnaires")) {
            final encodedPQ =
                await secureStorage.read("shared_patient_questionnaires");
            final decodedPQ = jsonDecode(encodedPQ.toString()) as List<dynamic>;

            final List<SharedPatientQuestionnaire> documentsList = [];
            decodedPQ.map(
              (e) {
                documentsList.add(
                  SharedPatientQuestionnaire.fromJson(
                      e as Map<String, dynamic>),
                );
              },
            ).toList();
            documentsList.add(res);

            secureStorage.write(
              "shared_patient_questionnaires",
              jsonEncode(documentsList),
            );

            final newSessionState = sessionState.copyWith(
                sharedPatientQuestionnaires: documentsList);
            sessionCubit.startSessionWithVerifiedStateObj(newSessionState);
          } else {
            final newSessionState =
                sessionState.copyWith(sharedPatientQuestionnaires: [res]);
            await secureStorage.write(
                "shared_patient_questionnaires", jsonEncode([res]));
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