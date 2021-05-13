import 'package:did/providers/appScreenState/sessionFlow/sessionCubit.dart';
import 'package:did/providers/appScreenState/sessionFlow/sessionState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/credentialDetailsView.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(builder: (context, state) {
      if (state is Verified) {
        return CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              // if floating is true the appbar becomes instantly visible if scrolled towards top
              // if it's false the appbar is only visible if completly scrolled back to top
              floating: true,
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    "My profile",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                  titlePadding:
                      const EdgeInsetsDirectional.only(start: 20, bottom: 16)),
            ),
            SliverToBoxAdapter(
                child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: CredentialDetailsView(),
            ))
          ],
        );
      } else {
        return const Text("Unverified");
      }
    });
  }
}
