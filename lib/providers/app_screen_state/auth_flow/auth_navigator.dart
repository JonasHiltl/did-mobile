import 'package:did/screens/auth/creation/creation.dart';
import 'package:did/screens/auth/introduction/introduction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_cubit.dart';

class AuthNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Navigator(
          pages: [
            //display introduction page
            if (state == AuthState.introduction)
              const MaterialPage(child: Introduction()),
            //allow push Animation and display creation
            if (state == AuthState.creation) ...[
              MaterialPage(child: Creation()),
            ]
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
      },
    );
  }
}
