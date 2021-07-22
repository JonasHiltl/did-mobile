import 'package:did/providers/retrieve_document/retrieve_status.dart';

class RetrieveDocumentState {
  final String annLink;
  final String othersPublicKey;
  final RetrieveStatus retrieveStatus;

  RetrieveDocumentState({
    this.annLink = "",
    this.othersPublicKey = "",
    this.retrieveStatus = const InitialRetrieveStatus(),
  });

  RetrieveDocumentState copyWith({
    String? annLink,
    String? othersPublicKey,
    RetrieveStatus? retrieveStatus,
  }) {
    return RetrieveDocumentState(
      annLink: annLink ?? this.annLink,
      othersPublicKey: othersPublicKey ?? this.othersPublicKey,
      retrieveStatus: retrieveStatus ?? this.retrieveStatus,
    );
  }
}
