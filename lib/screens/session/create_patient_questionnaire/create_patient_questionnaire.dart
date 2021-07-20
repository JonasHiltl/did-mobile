import 'dart:io';

import 'package:did/global_components/loading_indicator.dart';
import 'package:did/global_components/noti.dart';
import 'package:did/global_components/universal_text_field.dart';
import 'package:did/providers/create_patient_questionnaire/form_submission_status.dart';
import 'package:did/providers/create_patient_questionnaire/create_PQ_bloc.dart';
import 'package:did/providers/create_patient_questionnaire/create_PQ_event.dart';
import 'package:did/providers/create_patient_questionnaire/create_PQ_state.dart';
import 'package:did/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../generated/l10n.dart';
import 'components/sliding_up_widget.dart';
import 'components/step1.dart';
import 'components/step2.dart';
import 'components/step3.dart';
import 'components/stepper.dart';

class CreatePatientQuestionnaire extends StatefulWidget {
  @override
  _CreatePatientQuestionnaireState createState() =>
      _CreatePatientQuestionnaireState();
}

class _CreatePatientQuestionnaireState
    extends State<CreatePatientQuestionnaire> {
  final panelController = PanelController();

  int currentStep = 0;

  void increseSubmit(BuildContext context) {
    if (currentStep < 2) {
      setState(() => currentStep++);
    } else {
      if (Platform.isAndroid) {
        showDialog(
          context: context,
          useRootNavigator: false,
          builder: (context) => AlertDialog(
            title: Text(L.of(context).createPQ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: kSmallPadding),
                  child: Text(L.of(context).givePQName),
                ),
                UniversalTextField(
                  initialValue: context.read<CreatePQBloc>().state.documentName,
                  prefixText: L.of(context).name,
                  onChanged: (value) => context
                      .read<CreatePQBloc>()
                      .add(CreatePQDocumentNameChanged(documentName: value)),
                ),
              ],
            ),
            actions: [
              BlocBuilder<CreatePQBloc, CreatePQState>(
                builder: (context, state) {
                  return TextButton(
                      onPressed: state.isValidDocumentName
                          ? () {
                              final FocusScopeNode currentFocus =
                                  FocusScope.of(context);

                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                              context
                                  .read<CreatePQBloc>()
                                  .add(CreatePQSubmitted());
                              Navigator.pop(context);
                            }
                          : null,
                      child: Text(L.of(context).submit));
                },
              ),
            ],
          ),
        );
      }
      if (Platform.isIOS) {
        showCupertinoDialog(
          context: context,
          useRootNavigator: false,
          builder: (context) => CupertinoAlertDialog(
            title: Text(L.of(context).createPQ),
            content: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: kSmallPadding),
                  child: Text(L.of(context).givePQName),
                ),
                CupertinoTextField(
                  onChanged: (value) => context
                      .read<CreatePQBloc>()
                      .add(CreatePQDocumentNameChanged(documentName: value)),
                )
              ],
            ),
            actions: [
              CupertinoDialogAction(
                  onPressed: () {
                    Navigator.pop(context);
                    context
                        .read<CreatePQBloc>()
                        .add(CreatePQResetDocumentName());
                  },
                  child: Text(L.of(context).no)),
              BlocBuilder<CreatePQBloc, CreatePQState>(
                builder: (context, state) {
                  return CupertinoDialogAction(
                      onPressed: state.isValidDocumentName
                          ? () {
                              final FocusScopeNode currentFocus =
                                  FocusScope.of(context);

                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                              context
                                  .read<CreatePQBloc>()
                                  .add(CreatePQSubmitted());
                              Navigator.pop(context);
                            }
                          : null,
                      child: Text(
                        L.of(context).yes,
                      ));
                },
              )
            ],
          ),
        );
      }
    }
  }

  void decreaseUntil0() {
    if (currentStep > 0) setState(() => currentStep--);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreatePQBloc, CreatePQState>(
      listener: (context, state) {
        if (state.formStatus is SubmissionSuccess) {
          showSuccessNoti(
              message: L.of(context).createPQSuccessMessage, context: context);
          Navigator.pop(context);
        } else if (state.formStatus is SubmissionFailed) {
          showErrorNoti(
              message: L.of(context).createPQErrorMessage, context: context);
        }
      },
      builder: (context, state) => SafeArea(
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0.0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.cancel,
                    size: 18,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
              title: Text(
                L.of(context).patientQuestionnaire,
                style: Theme.of(context).textTheme.headline5,
              ),
              centerTitle: true,
            ),
            body: Stack(
              children: [
                Positioned.fill(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: CustomStepper(
                          currentStep: currentStep,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(kMediumPadding),
                          child: LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints viewportConstraints) {
                              return SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight: viewportConstraints.maxHeight -
                                        MediaQuery.of(context).size.height *
                                            0.1,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IndexedStack(
                                        index: currentStep,
                                        children: <Widget>[
                                          Step1(),
                                          Step2(),
                                          Step3()
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: ElevatedButton(
                                                  onPressed: state.formStatus
                                                          is FormSubmitting
                                                      ? null
                                                      : () => increseSubmit(
                                                          context),
                                                  child: state.formStatus
                                                          is FormSubmitting
                                                      ? Container(
                                                          height: 19,
                                                          width: 19,
                                                          margin:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  7, 0, 7, 0),
                                                          child:
                                                              LoadingIndicator(
                                                            color: Theme.of(context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .light
                                                                ? const Color(
                                                                    0xFFD9D9D9)
                                                                : kTextFieldDarkBorder,
                                                          ),
                                                        )
                                                      : Text(
                                                          currentStep == 2
                                                              ? L
                                                                  .of(context)
                                                                  .submit
                                                              : L
                                                                  .of(context)
                                                                  .next,
                                                        ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: kSmallPadding,
                                              ),
                                              Expanded(
                                                child: OutlinedButton(
                                                  onPressed: currentStep == 0
                                                      ? null
                                                      : decreaseUntil0,
                                                  child: Text(
                                                    L.of(context).back,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          if (MediaQuery.of(context)
                                                  .size
                                                  .height <=
                                              640)
                                            const SizedBox(
                                              height: 50,
                                            )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SlidingUpWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
