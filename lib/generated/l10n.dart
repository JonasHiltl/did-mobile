// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class L {
  L();

  static L? _current;

  static L get current {
    assert(_current != null,
        'No instance of L was loaded. Try to initialize the L delegate before accessing L.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<L> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = L();
      L._current = instance;

      return instance;
    });
  }

  static L of(BuildContext context) {
    final instance = L.maybeOf(context);
    assert(instance != null,
        'No instance of L present in the widget tree. Did you add L.delegate in localizationsDelegates?');
    return instance!;
  }

  static L? maybeOf(BuildContext context) {
    return Localizations.of<L>(context, L);
  }

  /// `First Name`
  String get firstName {
    return Intl.message(
      'First Name',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get lastName {
    return Intl.message(
      'Last Name',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Date of Birth`
  String get dateOfBirth {
    return Intl.message(
      'Date of Birth',
      name: 'dateOfBirth',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Biological Sex`
  String get sex {
    return Intl.message(
      'Biological Sex',
      name: 'sex',
      desc: '',
      args: [],
    );
  }

  /// `Residential Address`
  String get residence {
    return Intl.message(
      'Residential Address',
      name: 'residence',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Postal Code`
  String get postalCode {
    return Intl.message(
      'Postal Code',
      name: 'postalCode',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `State`
  String get state {
    return Intl.message(
      'State',
      name: 'state',
      desc: '',
      args: [],
    );
  }

  /// `Let's create your digital Identity!`
  String get createHeader {
    return Intl.message(
      'Let\'s create your digital Identity!',
      name: 'createHeader',
      desc: '',
      args: [],
    );
  }

  /// `Digital Identity successfully created.`
  String get createSuccessMessage {
    return Intl.message(
      'Digital Identity successfully created.',
      name: 'createSuccessMessage',
      desc: '',
      args: [],
    );
  }

  /// `Your digital identity creation failed.`
  String get createErrorMessage {
    return Intl.message(
      'Your digital identity creation failed.',
      name: 'createErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `No Countries found`
  String get noCountriesFound {
    return Intl.message(
      'No Countries found',
      name: 'noCountriesFound',
      desc: '',
      args: [],
    );
  }

  /// `Create digital identity`
  String get introductionAction {
    return Intl.message(
      'Create digital identity',
      name: 'introductionAction',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Created at: `
  String get createdAt {
    return Intl.message(
      'Created at: ',
      name: 'createdAt',
      desc: '',
      args: [],
    );
  }

  /// `Personal Data`
  String get personalData {
    return Intl.message(
      'Personal Data',
      name: 'personalData',
      desc: '',
      args: [],
    );
  }

  /// `Update First Name`
  String get updateFirstName {
    return Intl.message(
      'Update First Name',
      name: 'updateFirstName',
      desc: '',
      args: [],
    );
  }

  /// `Update Last Name`
  String get updateLastName {
    return Intl.message(
      'Update Last Name',
      name: 'updateLastName',
      desc: '',
      args: [],
    );
  }

  /// `Update Email Address`
  String get updateEmail {
    return Intl.message(
      'Update Email Address',
      name: 'updateEmail',
      desc: '',
      args: [],
    );
  }

  /// `Update Phone Number`
  String get updatePhoneNumber {
    return Intl.message(
      'Update Phone Number',
      name: 'updatePhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Update Date of Birth`
  String get updateDateOfBirth {
    return Intl.message(
      'Update Date of Birth',
      name: 'updateDateOfBirth',
      desc: '',
      args: [],
    );
  }

  /// `Update Biological Sex`
  String get updateSex {
    return Intl.message(
      'Update Biological Sex',
      name: 'updateSex',
      desc: '',
      args: [],
    );
  }

  /// `Update Address`
  String get updateAddress {
    return Intl.message(
      'Update Address',
      name: 'updateAddress',
      desc: '',
      args: [],
    );
  }

  /// `Update City`
  String get updateCity {
    return Intl.message(
      'Update City',
      name: 'updateCity',
      desc: '',
      args: [],
    );
  }

  /// `Update State`
  String get updateState {
    return Intl.message(
      'Update State',
      name: 'updateState',
      desc: '',
      args: [],
    );
  }

  /// `Update Postal Code`
  String get updatePostalCode {
    return Intl.message(
      'Update Postal Code',
      name: 'updatePostalCode',
      desc: '',
      args: [],
    );
  }

  /// `Update Country`
  String get updateCountry {
    return Intl.message(
      'Update Country',
      name: 'updateCountry',
      desc: '',
      args: [],
    );
  }

  /// `The field must not be empty.`
  String get missingInput {
    return Intl.message(
      'The field must not be empty.',
      name: 'missingInput',
      desc: '',
      args: [],
    );
  }

  /// `Please input your first Name.`
  String get missingFirstName {
    return Intl.message(
      'Please input your first Name.',
      name: 'missingFirstName',
      desc: '',
      args: [],
    );
  }

  /// `Please input your last name.`
  String get missingLastName {
    return Intl.message(
      'Please input your last name.',
      name: 'missingLastName',
      desc: '',
      args: [],
    );
  }

  /// `Please input your email.`
  String get missingEmail {
    return Intl.message(
      'Please input your email.',
      name: 'missingEmail',
      desc: '',
      args: [],
    );
  }

  /// `Not a valid Email.`
  String get invalidEmail {
    return Intl.message(
      'Not a valid Email.',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please input your phone Number.`
  String get missingPhoneNumber {
    return Intl.message(
      'Please input your phone Number.',
      name: 'missingPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please input your street and number.`
  String get missingAddress {
    return Intl.message(
      'Please input your street and number.',
      name: 'missingAddress',
      desc: '',
      args: [],
    );
  }

  /// `Please input your city.`
  String get missingCity {
    return Intl.message(
      'Please input your city.',
      name: 'missingCity',
      desc: '',
      args: [],
    );
  }

  /// `Please input your state.`
  String get missingState {
    return Intl.message(
      'Please input your state.',
      name: 'missingState',
      desc: '',
      args: [],
    );
  }

  /// `Please input your postal code.`
  String get missingPostalCode {
    return Intl.message(
      'Please input your postal code.',
      name: 'missingPostalCode',
      desc: '',
      args: [],
    );
  }

  /// `Please input your country.`
  String get missingCountry {
    return Intl.message(
      'Please input your country.',
      name: 'missingCountry',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<L> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<L> load(Locale locale) => L.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
