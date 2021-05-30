import 'package:did/models/patient_questionnaire/patient_questionnaire.dart';
import 'package:flutter/material.dart';

class TimeLine extends StatelessWidget {
  const TimeLine({
    Key? key,
    required this.i,
    required this.children,
  }) : super(key: key);

  final int i;
  final List<PatientQuestionnaireVc> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 2,
          height: i == 0 ? 75 : 95,
          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.2),
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            alignment: Alignment.center,
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Container(
              height: 5,
              width: 5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
        Container(
          height: 10,
          width: 2,
          color: i + 1 < children.length
              ? Theme.of(context).colorScheme.onBackground.withOpacity(0.2)
              : Theme.of(context).backgroundColor,
        ),
      ],
    );
  }
}
