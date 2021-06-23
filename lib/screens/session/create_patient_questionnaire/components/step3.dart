import 'package:did/global_components/universal_text_field.dart';
import 'package:did/models/medication/medication.dart';
import 'package:did/providers/create_patient_questionnaire/create_PQ_bloc.dart';
import 'package:did/providers/create_patient_questionnaire/create_PQ_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';

class Step3 extends StatefulWidget {
  @override
  _Step3State createState() => _Step3State();
}

class _Step3State extends State<Step3> {
  final TextEditingController medicationNameController =
      TextEditingController();
  final TextEditingController medicationConditionController =
      TextEditingController();
  final TextEditingController medicationFrequencyController =
      TextEditingController();
  final TextEditingController medicationDoseController =
      TextEditingController();

  String _medicationName = "";
  String _condition = "";
  String _frequency = "";
  String _dose = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(L.of(context).anyMedication,
            style: Theme.of(context).textTheme.headline5),
        const SizedBox(
          height: 10,
        ),
        Column(
          children: [
            UniversalTextField(
              prefixText: L.of(context).medication,
              hintText: L.of(context).exampleAspirin,
              controller: medicationNameController,
              onChanged: (value) => setState(() {
                _medicationName = value;
              }),
            ),
            const SizedBox(
              height: 10,
            ),
            UniversalTextField(
              prefixText: L.of(context).condition,
              hintText: L.of(context).exampleHeadaches,
              controller: medicationConditionController,
              onChanged: (value) => setState(() {
                _condition = value;
              }),
            ),
            const SizedBox(
              height: 10,
            ),
            UniversalTextField(
              prefixText: L.of(context).frequency,
              hintText: L.of(context).exampleOnceDaily,
              controller: medicationFrequencyController,
              onChanged: (value) => setState(
                () {
                  _frequency = value;
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            UniversalTextField(
              prefixText: L.of(context).dose,
              hintText: L.of(context).example75mg,
              controller: medicationDoseController,
              onChanged: (value) => setState(
                () {
                  _dose = value;
                },
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _medicationName.isEmpty ||
                        _condition.isEmpty ||
                        _frequency.isEmpty ||
                        _dose.isEmpty
                    ? null
                    : () => context.read<CreatePQBloc>().add(
                          CreatePQAddMedication(
                            medication: Medication(
                              name: medicationNameController.text,
                              condition: medicationConditionController.text,
                              frequency: medicationFrequencyController.text,
                              dose: medicationDoseController.text,
                            ),
                          ),
                        ),
                child: Text(L.of(context).addMedication),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
