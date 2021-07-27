import 'package:did/custom_icons/quader_font.dart';
import 'package:did/providers/app_screen_state/session_flow/session_state.dart';
import 'package:did/screens/session/documents/components/delete_received_pq_bottom_modal.dart';
import 'package:did/screens/session/documents/components/document_card.dart';
import 'package:did/screens/session/documents/detailed_bottom_sheets/received_pq_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
    final sessionState = context.watch<SessionState>();
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
            // drei in einer Reihe crossAxisCount: 3 staggeredTileBuilder: 1
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: kMediumPadding - kSmallPadding / 2,
              ),
              sliver: SliverToBoxAdapter(
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: <Widget>[
                    for (var i = 0;
                        i < sessionState.receivedPatientQuestionnaires.length;
                        i++)
                      SizedBox(
                        width: segmentedControlGroupValue == 1
                            ? double.infinity
                            : segmentedControlGroupValue == 2
                                ? MediaQuery.of(context).size.width / 2 -
                                    (kMediumPadding - kSmallPadding / 2)
                                : MediaQuery.of(context).size.width / 3 -
                                    (kMediumPadding - kSmallPadding),
                        child: Card(
                          margin: const EdgeInsets.fromLTRB(
                            kSmallPadding / 2,
                            0,
                            kSmallPadding / 2,
                            kSmallPadding,
                          ),
                          child: InkWell(
                            // TODO: create detailed bottom sheet for the shared patient questionnaries
                            onTap: () => showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) =>
                                  ReceivedPQDetailedBottomSheet(
                                i: i,
                              ),
                            ),
                            onLongPress: () => receivedPqBottomModal(
                              context,
                              i,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: segmentedControlGroupValue! > 1 &&
                                      MediaQuery.of(context).size.width <= 480
                                  ? VerticalDocumentCard(
                                      icon: Icon(
                                        Icons.assignment,
                                        color: Colors.teal.shade400,
                                        size: 30,
                                      ),
                                      title:
                                          "${sessionState.receivedPatientQuestionnaires[i].presentation.verifiableCredential.credentialSubject.firstName} ${sessionState.receivedPatientQuestionnaires[i].presentation.verifiableCredential.credentialSubject.lastName}",
                                      subtitle: DateFormat.yMMMd().format(
                                        DateTime.parse(
                                          sessionState
                                              .receivedPatientQuestionnaires[i]
                                              .accessVc
                                              .issuanceDate,
                                        ).toLocal(),
                                      ),
                                      onPressed: () => receivedPqBottomModal(
                                        context,
                                        i,
                                      ),
                                    )
                                  : HorizontalDocumentCard(
                                      icon: Icon(
                                        Icons.assignment,
                                        color: Colors.teal.shade400,
                                        size: 30,
                                      ),
                                      title:
                                          "${sessionState.receivedPatientQuestionnaires[i].presentation.verifiableCredential.credentialSubject.firstName} ${sessionState.receivedPatientQuestionnaires[i].presentation.verifiableCredential.credentialSubject.lastName}",
                                      subtitle: DateFormat.yMMMd().format(
                                        DateTime.parse(
                                          sessionState
                                              .receivedPatientQuestionnaires[i]
                                              .accessVc
                                              .issuanceDate,
                                        ).toLocal(),
                                      ),
                                      onPressed: () => receivedPqBottomModal(
                                        context,
                                        i,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
