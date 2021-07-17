import 'package:did/models/dynamic_credential/dynamic_credential.dart';
import 'package:did/providers/share_document/share_status.dart';

class ShareDocumentState {
  final String id;
  final DynamicCredential credential;
  final ShareStatus shareStatus;
  final String channelLink;

  ShareDocumentState({
    required this.id,
    required this.credential,
    this.channelLink = "",
    this.shareStatus = const InitialShareStatus(),
  });

  ShareDocumentState copyWith({
    String? channelLink,
    String? id,
    DynamicCredential? credential,
    ShareStatus? shareStatus,
  }) {
    return ShareDocumentState(
      channelLink: channelLink ?? this.channelLink,
      id: id ?? this.id,
      credential: credential ?? this.credential,
      shareStatus: shareStatus ?? this.shareStatus,
    );
  }
}
