import 'package:did/custom_icons/quader_font.dart';
import 'package:did/global_components/alert.dart';
import 'package:did/global_components/loading_indicator.dart';
import 'package:did/global_components/material_bottom_sheet.dart';
import 'package:did/global_components/noti.dart';
import 'package:did/models/dynamic_credential/dynamic_credential.dart';
import 'package:did/models/dynamic_credential/proof.dart';
import 'package:did/providers/app_screen_state/session_flow/session_cubit.dart';
import 'package:did/providers/app_screen_state/session_flow/session_state.dart';
import 'package:did/providers/share_document/repo/share_document_repo.dart';
import 'package:did/providers/share_document/share_document_bloc.dart';
import 'package:did/providers/share_document/share_document_event.dart';
import 'package:did/providers/share_document/share_document_state.dart';
import 'package:did/providers/share_document/share_status.dart';
import 'package:did/screens/session/documents/components/bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../generated/l10n.dart';

class PQDocumentFolder extends StatefulWidget {
  final String appBarTitle;
  const PQDocumentFolder({required this.appBarTitle});

  @override
  _PQDocumentFolderState createState() => _PQDocumentFolderState();
}

class _PQDocumentFolderState extends State<PQDocumentFolder> {
  int? segmentedControlGroupValue = 1;

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
                        segmentedControlGroupValue = value as int?;
                      }),
                    ),
                  ],
                ),
              ),
            ),
            if (sessionState.patientQuestionnaires.isNotEmpty)
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                sliver: SliverGrid.count(
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
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
                          onLongPress: () =>
                              bottomModal(context, i, sessionState),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.assignment,
                                  color: Theme.of(context).primaryColor,
                                  size: segmentedControlGroupValue == 1
                                      ? 30
                                      : segmentedControlGroupValue == 2
                                          ? 28
                                          : 24,
                                ),
                                if (segmentedControlGroupValue == 1)
                                  const SizedBox(
                                    width: 8,
                                  ),
                                if (segmentedControlGroupValue == 2)
                                  const SizedBox(
                                    width: 2,
                                  ),
                                Expanded(
                                  child: Wrap(
                                    runAlignment: WrapAlignment.center,
                                    alignment: WrapAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      Text(
                                        sessionState.patientQuestionnaires[i]
                                            .credentialSubject.documentName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        DateFormat.yMMMd().format(
                                            DateTime.parse(sessionState
                                                    .patientQuestionnaires[i]
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
                                    ],
                                  ),
                                ),
                                IconButton(
                                    padding: const EdgeInsets.all(0.0),
                                    visualDensity: VisualDensity.compact,
                                    onPressed: () =>
                                        bottomModal(context, i, sessionState),
                                    icon: const Icon(Icons.more_vert))
                              ],
                            ),
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

// The
  void bottomModal(BuildContext context, int i, Verified sessionState) =>
      /* Platform.isIOS
          ? showCupertinoModalPopup(
              useRootNavigator: false,
              context: context,
              builder: (context) => CupertinoActionSheet(
                actions: [
                  RepositoryProvider(
                    create: (context) => ShareDocumentRepo(),
                    child: BlocProvider(
                      create: (context) => ShareDocumentBloc(
                        repo: context.read<ShareDocumentRepo>(),
                        credential: DynamicCredential(
                          context:
                              sessionState.patientQuestionnaires[i].context,
                          id: sessionState.patientQuestionnaires[i].id,
                          type: sessionState.patientQuestionnaires[i].type,
                          credentialSubject: sessionState
                              .patientQuestionnaires[i].credentialSubject,
                          issuer: sessionState.patientQuestionnaires[i].issuer,
                          issuanceDate: sessionState
                              .patientQuestionnaires[i].issuanceDate,
                          proof: Proof(
                              type: sessionState
                                  .patientQuestionnaires[i].proof.type,
                              signatureValue: sessionState
                                  .patientQuestionnaires[i]
                                  .proof
                                  .signatureValue,
                              verificationMethod: sessionState
                                  .patientQuestionnaires[i]
                                  .proof
                                  .verificationMethod),
                        ),
                        doc: sessionState.identity.doc,
                      ),
                      child: Builder(builder: (context) {
                        return BlocListener<ShareDocumentBloc,
                            ShareDocumentState>(
                          listener: (context, state) {
                            if (state.shareStatus is ShareFailed) {
                              Navigator.of(context).pop();
                              showErrorNoti(
                                message: L.of(context).shareDocErrorMessage,
                                context: context,
                              );
                            } else if (state.shareStatus is ShareSuccess) {
                              Navigator.of(context).pop();
                              showSuccessNoti(
                                message: L.of(context).shareDocSuccessMessage,
                                context: context,
                              );
                              bottomSheet(
                                title: L.of(context).share,
                                context: context,
                                content: [
                                  QrImage(
                                    data: state.channelLink,
                                    size: 200.0,
                                  )
                                ],
                              );
                            }
                          },
                          child: BlocBuilder<ShareDocumentBloc,
                              ShareDocumentState>(
                            builder: (context, state) {
                              return CupertinoActionSheetAction(
                                onPressed: () => context
                                    .read<ShareDocumentBloc>()
                                    .add(ShareDocument()),
                                child: state.shareStatus is Sharing
                                    ? const LoadingIndicator()
                                    : Text(L.of(context).share),
                              );
                            },
                          ),
                        );
                      }),
                    ),
                  ),
                  CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        context.read<SessionCubit>().deletePQ(i, sessionState);
                      });
                    },
                    child: Text(
                      L.of(context).delete,
                      style: TextStyle(color: Theme.of(context).errorColor),
                    ),
                  ),
                ],
                cancelButton: CupertinoActionSheetAction(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    L.of(context).cancel,
                  ),
                ),
              ),
            )
          :  */
      bottomSheet(
        context: context,
        content: [
          RepositoryProvider(
            create: (context) => ShareDocumentRepo(),
            child: BlocProvider(
              create: (context) => ShareDocumentBloc(
                repo: context.read<ShareDocumentRepo>(),
                credential: DynamicCredential(
                  context: sessionState.patientQuestionnaires[i].context,
                  id: sessionState.patientQuestionnaires[i].id,
                  type: sessionState.patientQuestionnaires[i].type,
                  credentialSubject:
                      sessionState.patientQuestionnaires[i].credentialSubject,
                  issuer: sessionState.patientQuestionnaires[i].issuer,
                  issuanceDate:
                      sessionState.patientQuestionnaires[i].issuanceDate,
                  proof: Proof(
                      type: sessionState.patientQuestionnaires[i].proof.type,
                      signatureValue: sessionState
                          .patientQuestionnaires[i].proof.signatureValue,
                      verificationMethod: sessionState
                          .patientQuestionnaires[i].proof.verificationMethod),
                ),
                doc: sessionState.identity.doc,
              ),
              child: Builder(builder: (context) {
                return BlocConsumer<ShareDocumentBloc, ShareDocumentState>(
                  listener: (context, state) {
                    if (state.shareStatus is ShareFailed) {
                      Navigator.of(context).pop();
                      showErrorNoti(
                          message: L.of(context).shareDocErrorMessage,
                          context: context);
                    } else if (state.shareStatus is ShareSuccess) {
                      Navigator.of(context).pop();
                      showSuccessNoti(
                          message: L.of(context).shareDocSuccessMessage,
                          context: context);
                      bottomSheet(
                        context: context,
                        title: L.of(context).share,
                        content: [
                          SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Center(
                              child: QrImage(
                                data: state.channelLink,
                                size: 200.0,
                              ),
                            ),
                          )
                        ],
                      );
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      children: [
                        if (state.shareStatus is Sharing)
                          LoadingAlert(
                            title: L.of(context).sharing,
                            message: L.of(context).sharemessage,
                          )
                        else ...[
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: state.shareStatus is Sharing
                                  ? null
                                  : () => context
                                      .read<ShareDocumentBloc>()
                                      .add(ShareDocument()),
                              child: state.shareStatus is Sharing
                                  ? const SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: LoadingIndicator())
                                  : Text(L.of(context).share,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                setState(() {
                                  context
                                      .read<SessionCubit>()
                                      .deletePQ(i, sessionState);
                                });
                              },
                              child: Text(
                                L.of(context).delete,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: Theme.of(context).errorColor,
                                    ),
                              ),
                            ),
                          ),
                        ]
                      ],
                    );
                  },
                );
              }),
            ),
          ),
        ],
      );
}
