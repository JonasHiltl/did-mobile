import 'package:flutter/material.dart';

class CreateFirstQuestionnaire extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(6),
      child: InkWell(
        highlightColor: const Color(0xFF2C54E9),
        borderRadius: BorderRadius.circular(6),
        onTap: () => print("navigate to patient questionnarie creation"),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Row(children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1), shape: BoxShape.circle),
              child: Icon(
                Icons.description_outlined,
                color: Colors.white.withOpacity(0.9),
                size: 26,
              ),
            ),
            const SizedBox(
              width: 24,
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
                    height: 6,
                  ),
                  Text(
                    "Let's create your first patient questionnaire to reuse for any doctor.",
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
