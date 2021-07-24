import 'package:did/global_components/empty.dart';
import 'package:did/providers/app_screen_state/session_flow/session_state.dart';
import 'package:did/screens/session/documents/components/document_folder_preview.dart';
import 'package:did/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../../generated/l10n.dart';
import 'document_folder/pq_document_folder.dart';

class TabView1 extends StatelessWidget {
  const TabView1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sessionState = context.watch<Verified>();
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kMediumPadding,
              vertical: kSmallPadding,
            ),
            child: Text(
              L.of(context).ownDocs,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          if (sessionState.patientQuestionnaires.isEmpty) ...[
            const SizedBox(
              height: kMediumPadding + kSmallPadding,
            ),
            Empty(
              text: L.of(context).noOwnDocs,
            )
          ] else
            Padding(
              padding: const EdgeInsets.fromLTRB(
                kMediumPadding,
                kSmallPadding,
                0,
                kSmallPadding,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: <Widget>[
                    if (sessionState.patientQuestionnaires.isNotEmpty)
                      DocumentFolderPreview(
                        backgroundColor: Theme.of(context).primaryColor,
                        icon: Icon(
                          Icons.assignment,
                          color: Theme.of(context).primaryColor,
                          size: 26,
                        ),
                        title: L.of(context).patientQuestionnaires,
                        items: sessionState.patientQuestionnaires.length,
                        onTap: () => Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.bottomToTop,
                            curve: Curves.easeInOut,
                            child: const PQDocumentFolder(),
                          ),
                        ),
                      ),
                    const SizedBox(
                      width: kSmallPadding,
                    ),
                    DocumentFolderPreview(
                      backgroundColor: Colors.red,
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 26,
                      ),
                      title: "Test",
                      items: 3,
                      onTap: () => Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.bottomToTop,
                          curve: Curves.easeInOut,
                          child: const PQDocumentFolder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
