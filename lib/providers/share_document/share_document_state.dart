import 'package:did/models/did/doc.dart';
import 'package:did/models/dynamic_credential/dynamic_credential.dart';
import 'package:did/providers/share_document/share_status.dart';

class ShareDocumentState {
  final Doc doc;
  final DynamicCredential credential;
  final ShareStatus shareStatus;

  ShareDocumentState({
    required this.doc,
    required this.credential,
    this.shareStatus = const InitialShareStatus(),
  });

  ShareDocumentState copyWith(
      {Doc? doc, DynamicCredential? credential, ShareStatus? shareStatus}) {
    return ShareDocumentState(
      doc: doc ?? this.doc,
      credential: credential ?? this.credential,
      shareStatus: shareStatus ?? this.shareStatus,
    );
  }
}
