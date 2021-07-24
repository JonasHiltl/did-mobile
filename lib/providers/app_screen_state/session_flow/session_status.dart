abstract class SessionStatus {
  const SessionStatus();
}

class UnkownSessionStatus extends SessionStatus {
  const UnkownSessionStatus();
}

class Unverified extends SessionStatus {}

class Verified extends SessionStatus {}
