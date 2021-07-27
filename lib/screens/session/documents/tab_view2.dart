import 'package:did/global_components/empty.dart';
import 'package:did/providers/app_screen_state/session_flow/session_state.dart';
import 'package:did/screens/session/documents/components/document_folder_preview.dart';
import 'package:did/screens/session/documents/document_folder/received_pq_document_folder.dart';
import 'package:did/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../../generated/l10n.dart';

class TabView2 extends StatelessWidget {
  const TabView2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sessionState = context.watch<SessionState>();
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            L.of(context).receivedDocs,
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(
            height: kMediumPadding,
          ),
          if (sessionState.receivedPatientQuestionnaires.isEmpty) ...[
            const SizedBox(
              height: kMediumPadding,
            ),
            Center(
              child: Empty(
                text: L.of(context).noDocReceived,
              ),
            )
          ] else
            DocumentFolderPreview(
              backgroundColor: Colors.teal.shade400,
              icon: Icon(
                Icons.assignment,
                color: Colors.teal.shade400,
                size: 26,
              ),
              title: L.of(context).receivedPatientQuestionnaire,
              items: sessionState.receivedPatientQuestionnaires.length,
              onTap: () => Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.bottomToTop,
                  curve: Curves.easeInOut,
                  child: const ReceivedPQDocumentFolder(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
