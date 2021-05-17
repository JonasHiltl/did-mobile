import 'package:did/providers/appScreenState/sessionFlow/sessionState.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/l10n.dart';
import 'components/sliding_up_widget.dart';
import 'components/stepper.dart';
import 'components/textField.dart';

class CreatePatientQuestionnaire extends StatefulWidget {
  @override
  _CreatePatientQuestionnaireState createState() =>
      _CreatePatientQuestionnaireState();
}

class _CreatePatientQuestionnaireState
    extends State<CreatePatientQuestionnaire> {
  final panelController = PanelController();

  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final credential =
        context.watch<Verified>().personalDataVc.credentialSubject;
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
                "Patient Questionnaire",
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
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: IndexedStack(
                    index: currentStep,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            L.of(context).personalData,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          Row(children: [
                            DynamicTextField(
                                initialValue: credential.firstName,
                                label: L.of(context).firstName),
                            const SizedBox(
                              width: 10,
                            ),
                            DynamicTextField(
                                initialValue: credential.lastName,
                                label: L.of(context).lastName),
                          ]),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(children: [
                            DynamicTextField(
                                initialValue: credential.email,
                                label: L.of(context).email),
                            const SizedBox(
                              width: 10,
                            ),
                            DynamicTextField(
                              initialValue: credential.phoneNumber,
                              label: L.of(context).phoneNumber,
                            ),
                          ]),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(children: [
                            DynamicTextField(
                                initialValue: DateFormat.yMMMd()
                                    .format(credential.dateOfBirth),
                                label: L.of(context).dateOfBirth),
                            const SizedBox(
                              width: 10,
                            ),
                            DynamicTextField(
                                initialValue: credential.sex == "male"
                                    ? L.of(context).male
                                    : L.of(context).female,
                                label: L.of(context).simpleSex),
                          ]),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(children: [
                            DynamicTextField(
                                initialValue:
                                    "${credential.address.street}, ${credential.address.postalCode} ${credential.address.city},  ${credential.address.state} ${credential.address.country}",
                                label: L.of(context).address),
                          ]),
                        ],
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: () => {}, child: Text(L.of(context).next)),
                Container(
                  color: Colors.black12,
                  height: MediaQuery.of(context).size.height * 0.1 + 100,
                )
              ],
            ))));
  }
}
