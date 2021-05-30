import 'package:did/providers/appScreenState/sessionFlow/sessionCubit.dart';
import 'package:did/providers/appScreenState/sessionFlow/sessionState.dart';
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
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  for (var i = 0;
                      i < sessionState.patientQuestionnaires.length;
                      i++)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 10.0, left: 20.0),
                          child: Text(
                            DateFormat().add_jm().format(DateTime.parse(
                                    sessionState
                                        .patientQuestionnaires[i].issuanceDate)
                                .toLocal()),
                          ),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        TimeLine(
                            i: i, children: sessionState.patientQuestionnaires),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Material(
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
                                        )),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Wrap(
                                        children: [
                                          Text(
                                            sessionState
                                                .patientQuestionnaires[i]
                                                .credentialSubject
                                                .documentName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                            overflow: TextOverflow.fade,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Wrap(
                                        alignment: WrapAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: [
                                          Text(
                                            "${L.of(context).issued}${DateFormat.yMMMd().format(DateTime.parse(sessionState.patientQuestionnaires[i].issuanceDate).toLocal())}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onBackground
                                                        .withOpacity(0.5)),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Wrap(
                                            children: [
                                              GestureDetector(
                                                onTap: () => setState(() {
                                                  context
                                                      .read<SessionCubit>()
                                                      .deletePQ(
                                                          i, sessionState);
                                                }),
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Theme.of(context)
                                                      .errorColor,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              GestureDetector(
                                                onTap: () => print("Share $i"),
                                                child: Icon(
                                                  Icons.share,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
