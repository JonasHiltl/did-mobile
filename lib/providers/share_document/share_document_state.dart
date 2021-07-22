import 'package:did/models/dynamic_credential/dynamic_credential.dart';
import 'package:did/providers/share_document/share_status.dart';

class ShareDocumentState {
  final String id;
  final DynamicCredential credential;
  final ShareStatus shareStatus;
  final String channelLink;
  final bool noExpiration;
  final DateTime? expirationDate;
  final DateTime? expirationTime;
  bool get isValidExpirationDate => expirationDate is DateTime;
  bool get isValidExpirationTime => expirationTime is DateTime;

  DateTime? get expirationMoment =>
      isValidExpirationDate && isValidExpirationTime
          ? DateTime(
              expirationDate!.year,
              expirationDate!.month,
              expirationDate!.day,
              expirationTime!.hour,
              expirationTime!.minute,
              expirationTime!.second,
            )
          : null;

  ShareDocumentState({
    required this.id,
    required this.credential,
    this.noExpiration = false,
    this.expirationDate,
    this.expirationTime,
    this.channelLink = "",
    this.shareStatus = const InitialShareStatus(),
  });

  ShareDocumentState copyWith({
    String? channelLink,
    String? id,
    DynamicCredential? credential,
    ShareStatus? shareStatus,
    bool? noExpiration,
    DateTime? expirationDate,
    DateTime? expirationTime,
  }) {
    return ShareDocumentState(
      channelLink: channelLink ?? this.channelLink,
      id: id ?? this.id,
      credential: credential ?? this.credential,
      shareStatus: shareStatus ?? this.shareStatus,
      noExpiration: noExpiration ?? this.noExpiration,
      expirationDate: expirationDate,
      expirationTime: expirationTime,
    );
  }
}
