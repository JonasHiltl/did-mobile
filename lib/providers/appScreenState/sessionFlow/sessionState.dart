import 'package:did/models/did/identity.dart';
import 'package:did/models/personal_data_vc/personal_data_vc.dart';

abstract class SessionState {}

class UnkownSessionState extends SessionState {}

class Unverified extends SessionState {}

class Verified extends SessionState {
  Verified({required this.identity, required this.personalDataVc});

  final Identity identity;
  final PersonalDataVc personalDataVc;
}
