import 'dart:convert';
import 'package:did/data/commonBackendRepo.dart';
import 'package:did/data/secureStorage.dart';
import 'package:did/models/did/did.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sessionState.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit(this.commonBackendRepo) : super(UnkownSessionState()) {
    attemptGettingDid();
  }

  final CommonBackendRepo commonBackendRepo;
  final SecureStorage secureStorage = SecureStorage();

  Future<void> attemptGettingDid() async {
    try {
      //await secureStorage.delete("did");
      if (await secureStorage.contains("did")) {
        final encodedDid = await secureStorage.read("did");
        final decodedDid =
            jsonDecode(encodedDid.toString()) as Map<String, dynamic>;

        final did = Did.fromJson(decodedDid);
        if (await commonBackendRepo.verifyDid(did.identity.doc.id)) {
          emit(Verified(did: did));
        } else {
          emit(Unverified());
        }
      } else {
        emit(Unverified());
      }
    } catch (e) {
      print("Sessioncubit error: $e");
      emit(Unverified());
    }
  }

  void showUnverified() => emit(Unverified());
  void showSession(Did did) {
    print("showing session");
    emit(Verified(did: did));
  }

  Future<void> clearDid() async {
    await secureStorage.delete("did");
    emit(Unverified());
  }
}
