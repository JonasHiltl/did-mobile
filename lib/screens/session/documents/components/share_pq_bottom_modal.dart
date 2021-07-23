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
import 'package:did/screens/session/documents/components/adjustable_datepicker.dart';
import 'package:did/screens/session/documents/components/adjustable_timepicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../generated/l10n.dart';
import '../../../../global_components/own_qr_image.dart';
import '../../../../theme.dart';

void sharePQBottomModal(
  BuildContext context,
  int i,
  Verified sessionState,
  TextEditingController dateController,
) =>
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
              id: sessionState.identity.doc.id,
            ),
            child: Builder(
              builder: (context) {
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
                            child: Column(
                              children: [
                                Center(
                                  // TODO: display public key to decrypt data on other side
                                  child: OwnQrImage(data: state.channelLink),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    } else if (state.noExpiration) {
                      dateController.text = "";
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
                        else if (state.shareStatus is Initializing) ...[
                          Center(
                            child: Text(
                              L.of(context).shareDocExpiryDate,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: state.noExpiration,
                                onChanged: (value) =>
                                    context.read<ShareDocumentBloc>().add(
                                          ChangeNoExpiration(
                                            noExpiration: !state.noExpiration,
                                          ),
                                        ),
                              ),
                              Text(
                                L.of(context).noExpiry,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: AdjustableDatePicker(
                                  dateController: dateController,
                                  currentTime: state.expirationDate is DateTime
                                      ? state.expirationDate
                                      : DateTime.now(),
                                  state: state,
                                  prefixText: state.expirationDate != null
                                      ? DateFormat.yMd().format(
                                          state.expirationDate!,
                                        )
                                      : L.of(context).expirationDate,
                                  onConfirm: (date) =>
                                      context.read<ShareDocumentBloc>().add(
                                            ChangeExpirationDate(
                                              expirationDate: date,
                                            ),
                                          ),
                                ),
                              ),
                              const SizedBox(
                                width: kSmallPadding,
                              ),
                              Expanded(
                                child: AdjustableTimePicker(
                                  dateController: dateController,
                                  currentTime: state.expirationTime is DateTime
                                      ? state.expirationTime
                                      : DateTime.now(),
                                  state: state,
                                  prefixText: state.expirationTime != null
                                      ? DateFormat.jm().format(
                                          state.expirationTime!,
                                        )
                                      : L.of(context).expirationTime,
                                  onConfirm: (time) =>
                                      context.read<ShareDocumentBloc>().add(
                                            ChangeExpirationTime(
                                              expirationTime: time,
                                            ),
                                          ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: kSmallPadding,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: !state.isValidExpirationDate &&
                                          !state.isValidExpirationTime &&
                                          state.noExpiration ||
                                      state.isValidExpirationDate &&
                                          state.isValidExpirationTime &&
                                          !state.noExpiration
                                  ? () => context
                                      .read<ShareDocumentBloc>()
                                      .add(ShareDocument())
                                  : null,
                              child: state.shareStatus is Sharing
                                  ? const SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: LoadingIndicator(),
                                    )
                                  : Text(
                                      L.of(context).share,
                                    ),
                            ),
                          )
                        ] else ...[
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: state.shareStatus is Sharing
                                  ? null
                                  : () => context
                                      .read<ShareDocumentBloc>()
                                      .add(InitializeSharing()),
                              child: state.shareStatus is Sharing
                                  ? const SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: LoadingIndicator(),
                                    )
                                  : Text(
                                      L.of(context).share,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                context
                                    .read<SessionCubit>()
                                    .deletePQ(i, sessionState);
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
              },
            ),
          ),
        ),
      ],
    );
