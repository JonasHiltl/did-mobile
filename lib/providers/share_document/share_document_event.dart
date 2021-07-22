abstract class ShareDocumentEvent {}

class ShareDocument extends ShareDocumentEvent {}

class InitializeSharing extends ShareDocumentEvent {}

class ChangeNoExpiration extends ShareDocumentEvent {
  final bool noExpiration;

  ChangeNoExpiration({required this.noExpiration});
}

class ChangeExpirationDate extends ShareDocumentEvent {
  final DateTime expirationDate;

  ChangeExpirationDate({required this.expirationDate});
}

class ChangeExpirationTime extends ShareDocumentEvent {
  final DateTime expirationTime;

  ChangeExpirationTime({required this.expirationTime});
}
