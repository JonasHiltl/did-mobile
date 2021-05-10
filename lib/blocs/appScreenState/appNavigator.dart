import 'package:did/screens/creation/creation.dart';
import 'package:did/screens/loadingView.dart';
import 'package:did/screens/sessionView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

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
            if (state is UnkownSessionState) MaterialPage(child: LoadingView()),
            //show auth flow
            if (state is Unverified)
              MaterialPage(
                  child: BlocProvider(
                create: (context) => AuthCubit(context.read<SessionCubit>()),
                child: AuthNavigator(),
              )),
            //show session flow
            if (state is Verified) MaterialPage(child: SessionView())
          ],
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case "/create":
                return PageTransition(
                  child: Creation(),
                  type: PageTransitionType.fade,
                );
              default:
                return null;
            }
          },
          onPopPage: (route, result) => route.didPop(result),
        );
      },
    );
  }
}