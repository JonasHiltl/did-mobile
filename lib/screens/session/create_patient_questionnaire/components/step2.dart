import 'package:did/global_components/universal_text_field.dart';
import 'package:did/models/allergy/allergy.dart';
import 'package:did/providers/create_patient_questionnaire/create_PQ_bloc.dart';
import 'package:did/providers/create_patient_questionnaire/create_PQ_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';
import '../../../../theme.dart';

class Step2 extends StatefulWidget {
  @override
  _Step2State createState() => _Step2State();
}

class _Step2State extends State<Step2> {
  final TextEditingController allergyNameController = TextEditingController();
  final TextEditingController allergySymptomController =
      TextEditingController();

  String _allergyName = "";
  String _symptom = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(L.of(context).anyAllergies,
            style: Theme.of(context).textTheme.headline5),
        const SizedBox(
          height: kSmallPadding,
        ),
        Column(
          children: [
            UniversalTextField(
              prefixText: L.of(context).allergy,
              hintText: L.of(context).examplePollen,
              controller: allergyNameController,
              onChanged: (value) => setState(
                () {
                  _allergyName = value;
                },
              ),
            ),
            const SizedBox(
              height: kSmallPadding,
            ),
            UniversalTextField(
              prefixText: L.of(context).symptom,
              hintText: L.of(context).exampleSneezing,
              controller: allergySymptomController,
              onChanged: (value) => setState(
                () {
                  _symptom = value;
                },
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _allergyName.isEmpty || _symptom.isEmpty
                    ? null
                    : () => context.read<CreatePQBloc>().add(
                          CreatePQAddAllergy(
                            allergy: Allergy(
                              name: allergyNameController.text,
                              symptom: allergySymptomController.text,
                            ),
                          ),
                        ),
                child: Text(L.of(context).addAllergy),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
