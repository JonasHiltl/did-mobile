import 'package:did/global_components/universal_text_field.dart';
import 'package:did/providers/app_screen_state/session_flow/session_state.dart';
import 'package:did/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../generated/l10n.dart';

class Step1 extends StatelessWidget {
  final GlobalKey _toolTipKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final credential =
        context.watch<Verified>().personalDataVc.credentialSubject;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              L.of(context).personalData,
              style: Theme.of(context).textTheme.headline5,
            ),
            GestureDetector(
              onTap: () {
                final dynamic _toolTip = _toolTipKey.currentState;
                _toolTip.ensureTooltipVisible();
              },
              child: Tooltip(
                key: _toolTipKey,
                message: L.of(context).editProfile,
                child: const Icon(
                  Icons.help_outline,
                  size: 15,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: kSmallPadding,
        ),
        Column(
          children: [
            Row(children: [
              Expanded(
                child: UniversalTextField(
                  initialValue: credential.firstName,
                  prefixText: L.of(context).firstName,
                  readOnly: true,
                  textColor: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.6),
                ),
              ),
              const SizedBox(
                width: kSmallPadding,
              ),
              Expanded(
                child: UniversalTextField(
                  initialValue: credential.lastName,
                  prefixText: L.of(context).lastName,
                  readOnly: true,
                  textColor: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.6),
                ),
              ),
            ]),
            const SizedBox(
              height: kSmallPadding,
            ),
            Row(children: [
              Expanded(
                child: UniversalTextField(
                  initialValue: credential.email,
                  prefixText: L.of(context).email,
                  readOnly: true,
                  textColor: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.6),
                ),
              ),
              const SizedBox(
                width: kSmallPadding,
              ),
              Expanded(
                child: UniversalTextField(
                  initialValue: credential.phoneNumber,
                  prefixText: L.of(context).phoneNumber,
                  readOnly: true,
                  textColor: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.6),
                ),
              ),
            ]),
            const SizedBox(
              height: kSmallPadding,
            ),
            Row(
              children: [
                Expanded(
                  child: UniversalTextField(
                    initialValue:
                        DateFormat.yMMMd().format(credential.dateOfBirth),
                    prefixText: L.of(context).dateOfBirth,
                    readOnly: true,
                    textColor: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.6),
                  ),
                ),
                const SizedBox(
                  width: kSmallPadding,
                ),
                Expanded(
                  child: UniversalTextField(
                    initialValue: credential.sex == "male"
                        ? L.of(context).male
                        : L.of(context).female,
                    prefixText: L.of(context).simpleSex,
                    readOnly: true,
                    textColor: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.6),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: kSmallPadding,
            ),
            Row(
              children: [
                Expanded(
                  child: UniversalTextField(
                    initialValue:
                        "${credential.address.street}, ${credential.address.postalCode} ${credential.address.city},  ${credential.address.state} ${credential.address.country}",
                    prefixText: L.of(context).address,
                    readOnly: true,
                    textColor: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.6),
                  ),
                ),
              ],
            )
          ],
        ),
        Container()
      ],
    );
  }
}
