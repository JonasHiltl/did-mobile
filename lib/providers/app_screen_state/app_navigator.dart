import 'package:did/providers/share_document/repo/share_document_repo.dart';
import 'package:did/providers/share_document/share_document_bloc.dart';
import 'package:did/screens/startup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'auth_flow/auth_cubit.dart';
import 'auth_flow/auth_navigator.dart';
import 'session_flow/session_cubit.dart';
import 'session_flow/session_navigator.dart';
import 'session_flow/session_state.dart';

class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) {
        return Navigator(
          pages: [
            if (state is UnkownSessionState)
              MaterialPage(child: StartupScreen()),
            //show auth flow
            if (state is Unverified)
              MaterialPage(
                  child: BlocProvider(
                create: (context) => AuthCubit(context.read<SessionCubit>()),
                child: AuthNavigator(),
              )),
            //show session flow
            if (state is Verified)
              MaterialPage(
                  child: Provider.value(
                value: state,
                child: SessionNavigator(),
              ))
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
      },
    );
  }
}
