import 'package:did/models/did/doc.dart';
import 'package:did/models/dynamic_credential/dynamic_credential.dart';
import 'package:did/providers/share_document/repo/share_document_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuple/tuple.dart';

import 'share_document_event.dart';
import 'share_document_state.dart';
import 'share_status.dart';

class ShareDocumentBloc extends Bloc<ShareDocumentEvent, ShareDocumentState> {
  final ShareDocumentRepo repo;
  final Doc doc;
  final DynamicCredential credential;

  ShareDocumentBloc({
    required this.repo,
    required this.doc,
    required this.credential,
  }) : super(ShareDocumentState(doc: doc, credential: credential));

  @override
  Stream<ShareDocumentState> mapEventToState(ShareDocumentEvent event) async* {
    if (event is ShareDocument) {
      yield state.copyWith(shareStatus: Sharing());
      try {
        final res = await repo.createChannel(state.doc, state.credential);
        if (res.item2 != 200) {
          print(res);
          yield state.copyWith(shareStatus: ShareFailed(res.item1));
          yield state.copyWith(shareStatus: const InitialShareStatus());
        } else {
          print("Announcement Link: ${res.item1}");
        }
      } catch (e) {
        print(e);
        yield state.copyWith(shareStatus: ShareFailed(e.toString()));
        //yield initial state to counter the reappearing of noti after state changes (For example when keyboard gets closed or input changes)
        yield state.copyWith(shareStatus: const InitialShareStatus());
      }
    }
  }
}
