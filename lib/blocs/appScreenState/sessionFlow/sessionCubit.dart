import 'dart:convert';

import 'package:did/data/secureStorage.dart';
import 'package:did/models/did/did.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sessionState.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit() : super(UnkownSessionState()) {
    attemptGettingDid();
  }

  final SecureStorage secureStorage = SecureStorage();

  Future<void> attemptGettingDid() async {
    try {
      final encodedDid = await secureStorage.read("did");
      final decodedDid =
          jsonDecode(encodedDid.toString()) as Map<String, dynamic>;
      final did = Did.fromJson(decodedDid);
      // call /verify endpoint with did.id
      emit(Verified(did: did));
    } catch (e) {
      print("Sessioncubit error: $e");
      emit(Unverified());
    }
  }

  void showUnverified() => emit(Unverified());
  void showSession(Did did) {
    emit(Verified(did: did));
  }

  Future<void> clearDid() async {
    await secureStorage.delete("did");
    emit(Unverified());
  }
}
