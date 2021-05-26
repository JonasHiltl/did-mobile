import 'dart:convert';
import 'package:did/data/commonBackendRepo.dart';
import 'package:did/data/secureStorage.dart';
import 'package:did/models/did/identity.dart';
import 'package:did/models/personal_data_vc/personal_data_vc.dart';
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
      //await secureStorage.delete("identity");
      if (await secureStorage.contains("identity") &&
          await secureStorage.contains("personal_data_vc")) {
        final encodedDid = await secureStorage.read("identity");
        final decodedDid =
            jsonDecode(encodedDid.toString()) as Map<String, dynamic>;
        final identity = Identity.fromJson(decodedDid);

        final encodedPersonalDataVc =
            await secureStorage.read("personal_data_vc");
        final decodedPersonalDataVc =
            jsonDecode(encodedPersonalDataVc.toString())
                as Map<String, dynamic>;
        final personalDataVc = PersonalDataVc.fromJson(decodedPersonalDataVc);

        if (await commonBackendRepo.verifyDid(identity.doc.id)) {
          emit(Verified(identity: identity, personalDataVc: personalDataVc));
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
  void showSession(Identity identity, PersonalDataVc personalDataVc) {
    emit(Verified(identity: identity, personalDataVc: personalDataVc));
  }

  void startSessionWithVerifiedStateObj(Verified verified) {
    emit(Verified(
        identity: verified.identity,
        personalDataVc: verified.personalDataVc,
        patientQuestionnaires: verified.patientQuestionnaires));
  }

  Future<void> deleteAll() async {
    await secureStorage.deleteAll();
    emit(Unverified());
  }
}
