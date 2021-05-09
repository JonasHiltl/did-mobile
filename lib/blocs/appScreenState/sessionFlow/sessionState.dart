import 'package:did/models/did/did.dart';

abstract class SessionState {}

class UnkownSessionState extends SessionState {}

class Unverified extends SessionState {}

class Verified extends SessionState {
  Verified({required this.did});

  final Did did;
}
