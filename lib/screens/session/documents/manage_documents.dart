import 'dart:io';

import 'package:did/global_components/material_bottom_sheet.dart';
import 'package:did/providers/retrieve_document/retrieve_document_bloc.dart';
import 'package:did/providers/retrieve_document/retrieve_document_event.dart';
import 'package:did/screens/session/create_patient_questionnaire/create_patient_questionnaire.dart';
import 'package:did/screens/session/scan_qr/scan_qr.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../../generated/l10n.dart';
import '../../../theme.dart';
import './tab_view1.dart';
import './tab_view2.dart';

class ManageDocuments extends StatelessWidget {
  Future _openScanner(BuildContext context) async {
    final String result = await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => const ScanQR(),
      ),
    ) as String;

    context.read<RetrieveDocumentBloc>().add(ChangeAnnLink(annLink: result));
    // call the bloc to retrieve document
    print("back in manage docs");
    context.read<RetrieveDocumentBloc>().add(RetrieveDocument());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          body: NestedScrollView(
            physics: const BouncingScrollPhysics(),
            headerSliverBuilder: (context, value) {
              return [
                SliverAppBar(
                  // if floating is true the appbar becomes instantly visible if scrolled towards top
                  // if it's false the appbar is only visible if completly scrolled back to top
                  floating: true,
                  expandedHeight: 60.0,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  title: Text(
                    L.of(context).manageDocs,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                  centerTitle: true,
                  bottom: const TabBar(
                    tabs: [
                      Tab(
                        icon: Icon(
                          Icons.source,
                        ),
                      ),
                      Tab(
                        icon: Icon(
                          Icons.folder_shared,
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    IconButton(
                      onPressed: () => _openScanner(context),
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
                                    child: Text(
                                        L.of(context).patientQuestionnaire),
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
                                  child: Text(
                                      L.of(context).patientQuestionnaire,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                ),
                              ),
                            ]),
                    ),
                  ],
                ),
              ];
            },
            // TODO: show a popup while receiving Document
            body: const TabBarView(
              physics: BouncingScrollPhysics(),
              children: [
                TabView1(),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    kMediumPadding,
                    kSmallPadding,
                    kMediumPadding,
                    0,
                  ),
                  child: TabView2(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
