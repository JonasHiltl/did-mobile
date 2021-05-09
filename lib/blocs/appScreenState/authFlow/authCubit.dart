import 'package:did/blocs/appScreenState/sessionFlow/sessionCubit.dart';
import 'package:did/models/did/did.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AuthState { introduction, creation }

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.sessionCubit) : super(AuthState.introduction);
  final SessionCubit sessionCubit;

  void showIntroduction() => emit(AuthState.introduction);
  void showCreation() => emit(AuthState.creation);

  void launchSession(Did did) => sessionCubit.showSession(did);
}
