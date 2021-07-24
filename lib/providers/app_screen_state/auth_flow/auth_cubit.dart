import 'package:did/models/did/identity.dart';
import 'package:did/models/personal_data_vc/personal_data_vc.dart';
import 'package:did/providers/app_screen_state/session_flow/session_bloc.dart';
import 'package:did/providers/app_screen_state/session_flow/session_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../session_flow/session_bloc.dart';

enum AuthState { introduction, creation }

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this.sessionBloc,
  ) : super(
          AuthState.introduction,
        );
  final SessionBloc sessionBloc;

  void showIntroduction() => emit(AuthState.introduction);
  void showCreation() => emit(AuthState.creation);

  void launchSession(Identity identity, PersonalDataVc personalDataVc) =>
      sessionBloc.add(
          LaunchSession(identity: identity, personalDataVc: personalDataVc));
}
