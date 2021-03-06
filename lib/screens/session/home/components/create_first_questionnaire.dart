import 'package:did/theme.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../create_patient_questionnaire/create_patient_questionnaire.dart';

class CreateFirstQuestionnaire extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(6),
      child: InkWell(
        highlightColor: const Color(0xFF2C54E9),
        borderRadius: BorderRadius.circular(6),
        onTap: () => Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.bottomToTop,
            curve: Curves.easeInOut,
            child: CreatePatientQuestionnaire(),
          ),
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Row(children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(kSmallPadding),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1), shape: BoxShape.circle),
              child: Icon(
                Icons.assignment_outlined,
                color: Colors.white.withOpacity(0.9),
                size: 26,
              ),
            ),
            const SizedBox(
              width: kMediumPadding,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "First patient questionnaire!",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.white),
                  ),
                  const SizedBox(
                    height: kSmallPadding,
                  ),
                  Text(
                    "Let's create your first patient questionnaire to share with any doctor.",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.white.withOpacity(0.85)),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
