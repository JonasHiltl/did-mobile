import 'package:did/models/dynamic_credential/dynamic_credential.dart';
import 'package:did/providers/share_document/repo/share_document_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'share_document_event.dart';
import 'share_document_state.dart';
import 'share_status.dart';

class ShareDocumentBloc extends Bloc<ShareDocumentEvent, ShareDocumentState> {
  final ShareDocumentRepo repo;
  final String id;
  final DynamicCredential credential;

  ShareDocumentBloc({
    required this.repo,
    required this.id,
    required this.credential,
  }) : super(ShareDocumentState(id: id, credential: credential));

  @override
  Stream<ShareDocumentState> mapEventToState(ShareDocumentEvent event) async* {
    if (event is ShareDocument) {
      yield state.copyWith(shareStatus: Sharing());
      try {
        final res = await repo.createChannel(state.id, state.credential);
        if (res == null) {
          print(res);
          yield state.copyWith(
              shareStatus: ShareFailed("No announcement link returned"));
          yield state.copyWith(shareStatus: const InitialShareStatus());
        } else {
          yield state.copyWith(channelLink: res);
          yield state.copyWith(shareStatus: ShareSuccess());
          yield state.copyWith(shareStatus: const InitialShareStatus());
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
