import 'package:did/providers/appScreenState/sessionFlow/sessionState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../generated/l10n.dart';
import 'textField.dart';

class Step1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final credential =
        context.watch<Verified>().personalDataVc.credentialSubject;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          L.of(context).personalData,
          style: Theme.of(context).textTheme.headline5,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
        Row(children: [
          DynamicTextField(
              initialValue: credential.firstName,
              label: L.of(context).firstName),
          const SizedBox(
            width: 10,
          ),
          DynamicTextField(
              initialValue: credential.lastName, label: L.of(context).lastName),
        ]),
        const SizedBox(
          height: 10,
        ),
        Row(children: [
          DynamicTextField(
              initialValue: credential.email, label: L.of(context).email),
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
              initialValue: DateFormat.yMMMd().format(credential.dateOfBirth),
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
        ])
      ],
    );
  }
}
