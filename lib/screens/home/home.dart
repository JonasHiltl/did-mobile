import 'package:did/providers/appScreenState/sessionFlow/sessionCubit.dart';
import 'package:did/providers/appScreenState/sessionFlow/sessionState.dart';
import 'package:did/screens/home/components/createFirstQuestionnaire.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: BlocBuilder<SessionCubit, SessionState>(
              builder: (context, state) {
            if (state is Verified) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hi, ${state.did.credential.credentialSubject.firstName}",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    CreateFirstQuestionnaire(),
                  ]);
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
        ),
      ),
    );
  }
}
