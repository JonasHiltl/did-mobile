import 'package:did/blocs/appScreenState/sessionFlow/sessionCubit.dart';
import 'package:did/blocs/appScreenState/sessionFlow/sessionState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SessionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SessionCubit, SessionState>(builder: (context, state) {
        if (state is Verified) {
          return Center(
            child: Text(state.did.credential.credentialSubject.firstName),
          );
        } else if (state is UnkownSessionState) {
          return const Center(
            child: Text("Unauthenticated, please restart the app"),
          );
        } else {
          return const Center(
            child: Text("Unauthenticated, please restart the app"),
          );
        }
      }),
    );
  }
}
