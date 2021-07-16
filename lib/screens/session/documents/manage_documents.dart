import 'dart:io';

import 'package:did/global_components/material_bottom_sheet.dart';
import 'package:did/providers/app_screen_state/session_flow/session_state.dart';
import 'package:did/screens/session/create_patient_questionnaire/create_patient_questionnaire.dart';
import 'package:did/screens/session/documents/document_folder/pq_document_folder.dart';
import 'package:did/screens/session/scan_qr/scan_qr.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

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
              onPressed: () => Navigator.of(context, rootNavigator: true)
                  .push(MaterialPageRoute(
                builder: (context) => const ScanQR(),
              )),
              icon: Icon(
                Icons.qr_code,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              onPressed: () => Platform.isIOS
                  ? showCupertinoModalPopup(
                      useRootNavigator: false,
                      context: context,
                      builder: (context) => CupertinoActionSheet(
                        actions: [
                          CupertinoActionSheetAction(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.bottomToTop,
                                  curve: Curves.easeInOut,
                                  child: CreatePatientQuestionnaire(),
                                ),
                              );
                            },
                            child: Text(L.of(context).patientQuestionnaire),
                          ),
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(L.of(context).cancel),
                        ),
                      ),
                    )
                  : bottomSheet(context: context, content: [
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.bottomToTop,
                                curve: Curves.easeInOut,
                                child: CreatePatientQuestionnaire(),
                              ),
                            );
                          },
                          child: Text(L.of(context).patientQuestionnaire,
                              style: Theme.of(context).textTheme.bodyText1),
                        ),
                      ),
                    ]),
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
