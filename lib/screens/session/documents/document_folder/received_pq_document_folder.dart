import 'package:did/custom_icons/quader_font.dart';
import 'package:did/providers/app_screen_state/session_flow/session_state.dart';
import 'package:did/screens/session/documents/components/document_card.dart';
import 'package:did/screens/session/documents/detailed_bottom_modals/pq_detailed_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';
import '../../../../theme.dart';

class ReceivedPQDocumentFolder extends StatefulWidget {
  const ReceivedPQDocumentFolder({Key? key}) : super(key: key);

  @override
  _ReceivedPQDocumentFolderState createState() =>
      _ReceivedPQDocumentFolderState();
}

class _ReceivedPQDocumentFolderState extends State<ReceivedPQDocumentFolder> {
  final TextEditingController dateController = TextEditingController();
  int? segmentedControlGroupValue = 1;

  @override
  Widget build(BuildContext context) {
    final sessionState = context.watch<Verified>();
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              elevation: 0.0,
              floating: true,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Text(
                L.of(context).receivedPatientQuestionnaire,
                style: Theme.of(context).textTheme.headline5,
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.cancel,
                    size: 18,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kMediumPadding,
                  vertical: kSmallPadding,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      L.of(context).allFiles,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    CupertinoSlidingSegmentedControl(
                      groupValue: segmentedControlGroupValue,
                      padding: const EdgeInsets.all(6),
                      children: const {
                        1: Icon(Icons.menu),
                        2: Icon(
                          QuaderFont.th_large_1,
                          size: 16,
                        ),
                        3: Icon(Icons.apps)
                      },
                      onValueChanged: (value) => setState(() {
                        segmentedControlGroupValue = value as int?;
                      }),
                    ),
                  ],
                ),
              ),
            ),
            if (sessionState.sharedPatientQuestionnaires.isNotEmpty)
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kMediumPadding,
                  vertical: kSmallPadding,
                ),
                sliver: SliverGrid.count(
                  mainAxisSpacing: kSmallPadding,
                  crossAxisCount: segmentedControlGroupValue ?? 1,
                  childAspectRatio: MediaQuery.of(context).size.width >= 480
                      ? segmentedControlGroupValue == 1
                          ? MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 14)
                          : segmentedControlGroupValue == 2
                              ? MediaQuery.of(context).size.width /
                                  (MediaQuery.of(context).size.height / 6.9)
                              : MediaQuery.of(context).size.width /
                                  (MediaQuery.of(context).size.height / 4.6)
                      : segmentedControlGroupValue == 1
                          ? MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 10)
                          : segmentedControlGroupValue == 2
                              ? MediaQuery.of(context).size.width /
                                  (MediaQuery.of(context).size.height / 2.9)
                              : MediaQuery.of(context).size.width /
                                  (MediaQuery.of(context).size.height / 1.85),
                  children: <Widget>[
                    for (var i = 0;
                        i < sessionState.sharedPatientQuestionnaires.length;
                        i++)
                      Card(
                        child: InkWell(
                          // TODO: create detailed bottom sheet for the shared patient questionnaries
                          onTap: () => showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => PQDetailedBottomSheet(
                              i: i,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: segmentedControlGroupValue! > 1
                                ? VerticalDocumentCard(
                                    icon: Icons.assignment,
                                    title: sessionState
                                        .sharedPatientQuestionnaires[i]
                                        .presentation
                                        .verifiableCredential
                                        .credentialSubject
                                        .documentName,
                                    subtitle: DateFormat.yMMMd().format(
                                      DateTime.parse(
                                        sessionState
                                            .sharedPatientQuestionnaires[i]
                                            .presentation
                                            .verifiableCredential
                                            .issuanceDate,
                                      ).toLocal(),
                                    ),
                                    // TODO: create detailed bottom sheet for the shared patient questionnaries
                                    onPressed: () {},
                                  )
                                : HorizontalDocumentCard(
                                    icon: Icons.assignment,
                                    title: sessionState
                                        .sharedPatientQuestionnaires[i]
                                        .presentation
                                        .verifiableCredential
                                        .credentialSubject
                                        .documentName,
                                    subtitle: DateFormat.yMMMd().format(
                                      DateTime.parse(
                                        sessionState
                                            .sharedPatientQuestionnaires[i]
                                            .presentation
                                            .verifiableCredential
                                            .issuanceDate,
                                      ).toLocal(),
                                    ),
                                    // TODO: create detailed bottom sheet for the shared patient questionnaries
                                    onPressed: () {},
                                  ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
