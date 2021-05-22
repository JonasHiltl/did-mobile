import 'package:did/generated/l10n.dart';
import 'package:did/global_components/change_single_value_with_expand_icon.dart';
import 'package:did/global_components/credential.dart';
import 'package:did/providers/appScreenState/sessionFlow/sessionState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

import '../edit_individual_data/individual_address_update_screen.dart';
import '../edit_individual_data/individual_city_update_screen.dart';
import '../edit_individual_data/individual_country_update_screen.dart';
import '../edit_individual_data/individual_date_of_birth_update_screen.dart';
import '../edit_individual_data/individual_email_update_screen.dart';
import '../edit_individual_data/individual_firstname_update_screen.dart';
import '../edit_individual_data/individual_lastname_update_screen.dart';
import '../edit_individual_data/individual_phone_number_update_screen.dart';
import '../edit_individual_data/individual_postal_code_update_screen.dart';
import '../edit_individual_data/individual_sex_update_screen.dart';
import '../edit_individual_data/individual_state_update_screen.dart';

class CredentialDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final credential = context.watch<Verified>().personalDataVc;
    return Credential(
      title: L.of(context).personalInfoVC,
      children: <Widget>[
        ChangeSingleValueWithExpandIcon(
          label: L.of(context).firstName,
          value: credential.credentialSubject.firstName,
          onTap: () => Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  curve: Curves.easeInOut,
                  child: IndividualFirstNameUpdateScreen(
                    initialValue: credential.credentialSubject.firstName,
                  ))),
        ),
        ChangeSingleValueWithExpandIcon(
          label: L.of(context).lastName,
          value: credential.credentialSubject.lastName,
          onTap: () => Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  curve: Curves.easeInOut,
                  child: IndividualLastNameUpdateScreen(
                    initialValue: credential.credentialSubject.lastName,
                  ))),
        ),
        ChangeSingleValueWithExpandIcon(
          label: L.of(context).email,
          value: credential.credentialSubject.email,
          onTap: () => Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  curve: Curves.easeInOut,
                  child: IndividualEmailUpdateScreen(
                    initialValue: credential.credentialSubject.email,
                  ))),
        ),
        ChangeSingleValueWithExpandIcon(
          label: L.of(context).phoneNumber,
          value: credential.credentialSubject.phoneNumber,
          onTap: () => Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  curve: Curves.easeInOut,
                  child: IndividualPhoneNumberUpdateScreen(
                    initialValue: credential.credentialSubject.phoneNumber,
                  ))),
        ),
        ChangeSingleValueWithExpandIcon(
          label: L.of(context).dateOfBirth,
          value: DateFormat.yMMMd()
              .format(credential.credentialSubject.dateOfBirth),
          onTap: () => Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  curve: Curves.easeInOut,
                  child: IndividualDateOfBirthUpdateScreen(
                    initialValue: DateFormat.yMMMd()
                        .format(credential.credentialSubject.dateOfBirth),
                  ))),
        ),
        ChangeSingleValueWithExpandIcon(
          label: L.of(context).sex,
          value: credential.credentialSubject.sex == "male"
              ? L.of(context).male
              : L.of(context).female,
          onTap: () => Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  curve: Curves.easeInOut,
                  child: IndividualSexUpdateScreen(
                    initialValue: credential.credentialSubject.sex,
                  ))),
        ),
        ChangeSingleValueWithExpandIcon(
          label: L.of(context).address,
          value: credential.credentialSubject.address.street,
          onTap: () => Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  curve: Curves.easeInOut,
                  child: IndividualAddressUpdateScreen(
                    initialValue: credential.credentialSubject.address.street,
                  ))),
        ),
        ChangeSingleValueWithExpandIcon(
          label: L.of(context).city,
          value: credential.credentialSubject.address.city,
          onTap: () => Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  curve: Curves.easeInOut,
                  child: IndividualCityUpdateScreen(
                    initialValue: credential.credentialSubject.address.city,
                  ))),
        ),
        ChangeSingleValueWithExpandIcon(
          label: L.of(context).state,
          value: credential.credentialSubject.address.state,
          onTap: () => Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  curve: Curves.easeInOut,
                  child: IndividualStateUpdateScreen(
                    initialValue: credential.credentialSubject.address.state,
                  ))),
        ),
        ChangeSingleValueWithExpandIcon(
          label: L.of(context).postalCode,
          value: credential.credentialSubject.address.postalCode,
          onTap: () => Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  curve: Curves.easeInOut,
                  child: IndividualPostalCodeUpdateScreen(
                    initialValue:
                        credential.credentialSubject.address.postalCode,
                  ))),
        ),
        ChangeSingleValueWithExpandIcon(
          label: L.of(context).country,
          value: credential.credentialSubject.address.country,
          onTap: () => Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  curve: Curves.easeInOut,
                  child: IndividualCountryUpdateScreen(
                    initialValue: credential.credentialSubject.address.country,
                  ))),
        ),
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Divider(
            color: Colors.black38,
            height: 1,
            thickness: 0.6,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                L.of(context).createdAt,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.black),
              ),
              Text(
                DateFormat.yMMMd()
                    .add_jm()
                    .format(DateTime.parse(credential.issuanceDate).toLocal()),
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.black.withOpacity(0.6)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
