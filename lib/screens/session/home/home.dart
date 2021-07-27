import 'package:did/providers/app_screen_state/session_flow/session_state.dart';
import 'package:did/screens/session/home/components/create_first_questionnaire.dart';
import 'package:did/screens/session/home/components/personal_files_circular_graph.dart';
import 'package:did/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final sessionState = context.watch<SessionState>();
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverAppBar(
          elevation: 0.0,
          // if floating is true the appbar becomes instantly visible if scrolled towards top
          // if it's false the appbar is only visible if completly scrolled back to top
          floating: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            "Home",
            style: Theme.of(context).textTheme.headline5,
          ),
          centerTitle: true,
        ),
        if (sessionState.patientQuestionnaires.isEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: kSmallPadding,
                horizontal: kMediumPadding,
              ),
              child: CreateFirstQuestionnaire(),
            ),
          ),
        if (sessionState.patientQuestionnaires.isNotEmpty ||
            sessionState.receivedPatientQuestionnaires.isNotEmpty)
          const SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: kSmallPadding,
              horizontal: kMediumPadding,
            ),
            sliver: SliverToBoxAdapter(
              child: PersonalFilesCircularGraph(),
            ),
          ),
      ],
    );
  }
}
