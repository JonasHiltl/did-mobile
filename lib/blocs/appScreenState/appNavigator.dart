import 'package:did/screens/home/home.dart';
import 'package:did/screens/startupScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'authFlow/authCubit.dart';
import 'authFlow/authNavigator.dart';
import 'sessionFlow/sessionCubit.dart';
import 'sessionFlow/sessionState.dart';

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
            if (state is Verified) MaterialPage(child: Home())
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
      },
    );
  }
}
