import 'package:flutter/material.dart';
import 'package:did/global_components/minimal_change_language.dart';
import 'package:did/generated/l10n.dart';

import '../../../../theme.dart';
import 'customSteps.dart';
import 'customTextFields.dart';

class Page1 extends StatelessWidget {
  const Page1({required this.formKeys});
  final List<GlobalKey<FormState>> formKeys;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: kMediumPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: MinimalChangeLanguage(),
                    ),
                    Step1()
                  ],
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight - 70,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kMediumPadding,
                      ),
                      child: Text(
                        L.of(context).createHeader,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        kMediumPadding,
                        0,
                        kMediumPadding,
                        kMediumPadding,
                      ),
                      child: Form(
                        key: formKeys[0],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FirstNameField(),
                            const SizedBox(
                              height: kSmallPadding,
                            ),
                            LastNameField(),
                            const SizedBox(
                              height: kSmallPadding,
                            ),
                            EmailField(),
                            const SizedBox(
                              height: kSmallPadding,
                            ),
                            PhoneNumberField()
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
