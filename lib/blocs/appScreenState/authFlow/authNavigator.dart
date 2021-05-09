import 'package:did/screens/introduction/introduction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'authCubit.dart';

class AuthNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state == AuthState.introduction) {
          Navigator.pushReplacementNamed(context, "/introduction");
        }

        if (state == AuthState.creation) {
          Navigator.pushNamed(context, "/create");
        }
      },
      child: Introduction(),
    );
  }
}
