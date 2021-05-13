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
    return BlocBuilder<SessionCubit, SessionState>(builder: (context, state) {
      if (state is Verified) {
        return CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              // if floating is true the appbar becomes instantly visible if scrolled towards top
              // if it's false the appbar is only visible if completly scrolled back to top
              floating: true,
              expandedHeight: 60.0,
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    "Home",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  titlePadding:
                      const EdgeInsetsDirectional.only(start: 20, bottom: 16)),
            ),
            SliverToBoxAdapter(
                child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: CreateFirstQuestionnaire(),
            ))
          ],
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
    });
  }
}
