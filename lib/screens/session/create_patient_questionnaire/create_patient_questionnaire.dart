import 'package:flutter/material.dart';
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

  void increaseUntil2() {
    if (currentStep < 2) setState(() => currentStep++);
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
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IndexedStack(
                            index: currentStep,
                            children: <Widget>[Step1(), Step2(), Step3()],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                    onPressed: () => increaseUntil2(),
                                    child: Text(L.of(context).next)),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: OutlinedButton(
                                    onPressed: () => decreaseUntil0(),
                                    child: Text(L.of(context).next)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 0.1 + 59,
                          )
                        ]),
                  ),
                ),
              ],
            ))));
  }
}
