import 'package:did/providers/appScreenState/sessionFlow/sessionState.dart';
import 'package:did/screens/session/documents/document_folder/pq_document_folder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:popover/popover.dart';

import '../../../generated/l10n.dart';
import 'components/document_folder_preview.dart';

class ManageDocuments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sessionState = context.watch<Verified>();
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverAppBar(
          // if floating is true the appbar becomes instantly visible if scrolled towards top
          // if it's false the appbar is only visible if completly scrolled back to top
          floating: true,
          expandedHeight: 60.0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            "Manage Documents",
            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              onPressed: () => showPopover(
                context: context,
                bodyBuilder: (context) => Column(
                  children: [
                    Text(L.of(context).patientQuestionnaire),
                    Text(L.of(context).patientQuestionnaire),
                    Text(L.of(context).patientQuestionnaire),
                  ],
                ),
                direction: PopoverDirection.bottom,
              ),
            ),
          ],
        ),
        if (sessionState.patientQuestionnaires.isNotEmpty)
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Row(
                  children: [
                    DocumentFolderPreview(
                      backgroundColor: Theme.of(context).primaryColor,
                      icon: Icon(
                        Icons.assignment,
                        color: Theme.of(context).primaryColor,
                        size: 26,
                      ),
                      title: L.of(context).patientQuestionnaire,
                      subtitle: "${sessionState.patientQuestionnaires.length}" +
                          " Items",
                      onTap: () => Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.bottomToTop,
                          curve: Curves.easeInOut,
                          child: PQDocumentFolder(
                            appBarTitle: L.of(context).patientQuestionnaire,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    DocumentFolderPreview(
                      backgroundColor: Colors.red[400]!,
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.red[400],
                        size: 26,
                      ),
                      title: "Test",
                      subtitle: "${sessionState.patientQuestionnaires.length}" +
                          " Items",
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
