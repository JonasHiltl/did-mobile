import 'package:did/models/did/identity.dart';
import 'package:did/models/personal_data_vc/personal_data_vc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../session_flow/session_cubit.dart';

enum AuthState { introduction, creation }

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.sessionCubit) : super(AuthState.introduction);
  final SessionCubit sessionCubit;

  void showIntroduction() => emit(AuthState.introduction);
  void showCreation() => emit(AuthState.creation);

  void launchSession(Identity identity, PersonalDataVc personalDataVc) =>
      sessionCubit.showSession(identity, personalDataVc);
}
