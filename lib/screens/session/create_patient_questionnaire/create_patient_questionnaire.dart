import 'dart:io';

import 'package:did/global_components/universal_text_field.dart';
import 'package:did/providers/createPatientQuestionnaire/create_PQ_bloc.dart';
import 'package:did/providers/createPatientQuestionnaire/create_PQ_event.dart';
import 'package:did/providers/createPatientQuestionnaire/create_PQ_state.dart';
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
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(L.of(context).givePQName),
                ),
                UniversalTextField(
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
                  padding: EdgeInsets.symmetric(vertical: 8.0),
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
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0.0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              iconTheme: const IconThemeData(
                color: Colors.black,
              ),
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
            body: SlidingUpWidget(
                body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: CustomStepper(
                    currentStep: currentStep,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(children: [
                      Expanded(
                        child: IndexedStack(
                          index: currentStep,
                          children: <Widget>[Step1(), Step2(), Step3()],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () => increseSubmit(context),
                                child: Text(currentStep == 2
                                    ? L.of(context).submit
                                    : L.of(context).next)),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: OutlinedButton(
                                onPressed:
                                    currentStep == 0 ? null : decreaseUntil0,
                                child: Text(L.of(context).back)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1 + 159,
                      )
                    ]),
                  ),
                ),
              ],
            ))));
  }
}
