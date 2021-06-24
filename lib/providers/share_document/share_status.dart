abstract class ShareStatus {
  const ShareStatus();
}

class InitialShareStatus extends ShareStatus {
  const InitialShareStatus();
}

class Sharing extends ShareStatus {}

class ShareSuccess extends ShareStatus {}

class ShareFailed extends ShareStatus {
  ShareFailed(this.error);

  final String error;
}
