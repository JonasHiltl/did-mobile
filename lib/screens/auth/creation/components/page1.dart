import 'package:flutter/material.dart';
import 'package:did/global_components/minimalChangeLanguage.dart';
import 'package:did/generated/l10n.dart';

import 'customSteps.dart';
import 'customTextFields.dart';

class Page1 extends StatelessWidget {
  const Page1({required this.formKeys});
  final List<GlobalKey<FormState>> formKeys;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Center(child: MinimalChangeLanguage()), Step1()]),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKeys[0],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    L.of(context).createHeader,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  FirstNameField(),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  LastNameField(),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  EmailField(),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  PhoneNumberField()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
