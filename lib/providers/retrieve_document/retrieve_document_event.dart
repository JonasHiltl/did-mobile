abstract class RetrieveDocumentEvent {}

class RetrieveDocument extends RetrieveDocumentEvent {}

class ChangeAnnLink extends RetrieveDocumentEvent {
  final String annLink;

  ChangeAnnLink({required this.annLink});
}

class ChangePublicKey extends RetrieveDocumentEvent {
  final String publicKey;

  ChangePublicKey({required this.publicKey});
}
