import 'dart:io' show Platform;

import 'package:did/custom_icons/quader_font.dart';
import 'package:did/providers/app_screen_state/sessionFlow/sessionCubit.dart';
import 'package:did/providers/app_screen_state/sessionFlow/sessionState.dart';
import 'package:did/screens/session/documents/components/bottomSheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';
import '../components/timeline.dart';

class PQDocumentFolder extends StatefulWidget {
  final String appBarTitle;
  const PQDocumentFolder({required this.appBarTitle});

  @override
  _PQDocumentFolderState createState() => _PQDocumentFolderState();
}

class _PQDocumentFolderState extends State<PQDocumentFolder> {
  int segmentedControlGroupValue = 1;

  @override
  Widget build(BuildContext context) {
    final sessionState = context.watch<Verified>();
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) {
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              elevation: 0.0,
              floating: true,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              iconTheme: const IconThemeData(
                color: Colors.black,
              ),
              title: Text(
                widget.appBarTitle,
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
                    horizontal: 20.0, vertical: 10.0),
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
                        segmentedControlGroupValue = value as int;
                      }),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              sliver: SliverGrid.count(
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                crossAxisCount: segmentedControlGroupValue,
                childAspectRatio: segmentedControlGroupValue == 1
                    ? MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 6)
                    : segmentedControlGroupValue == 2
                        ? MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 2.9)
                        : MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 1.9),
                children: <Widget>[
                  for (var i = 0;
                      i < sessionState.patientQuestionnaires.length;
                      i++)
                    Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      elevation: 6,
                      shadowColor: Colors.black38,
                      child: InkWell(
                        onTap: () => showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => PQBottomSheet(
                            i: i,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Wrap(children: [
                            Icon(
                              Icons.assignment,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground
                                  .withOpacity(0.9),
                              size: segmentedControlGroupValue == 1
                                  ? 35
                                  : segmentedControlGroupValue == 2
                                      ? 30
                                      : 24,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              sessionState.patientQuestionnaires[i]
                                  .credentialSubject.documentName,
                              style: Theme.of(context).textTheme.bodyText1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              DateFormat.yMMMd().format(DateTime.parse(
                                      sessionState.patientQuestionnaires[i]
                                          .issuanceDate)
                                  .toLocal()),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground
                                        .withOpacity(0.5),
                                  ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ]),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
