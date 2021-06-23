import 'package:did/models/did/doc.dart';
import 'package:did/models/dynamic_credential/dynamic_credential.dart';
import 'package:did/providers/share_document/request_status.dart';

class ShareDocumentState {
  final Doc doc;
  final DynamicCredential credential;
  final RequestStatus requestStatus;

  ShareDocumentState({
    required this.doc,
    required this.credential,
    this.requestStatus = const InitialRequestStatus(),
  });
}
