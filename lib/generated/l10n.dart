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

  /// `First name`
  String get firstName {
    return Intl.message(
      'First name',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get lastName {
    return Intl.message(
      'Last name',
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

  /// `Phone number`
  String get phoneNumber {
    return Intl.message(
      'Phone number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Date of birth`
  String get dateOfBirth {
    return Intl.message(
      'Date of birth',
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

  /// `Biological sex`
  String get sex {
    return Intl.message(
      'Biological sex',
      name: 'sex',
      desc: '',
      args: [],
    );
  }

  /// `Residential address`
  String get residence {
    return Intl.message(
      'Residential address',
      name: 'residence',
      desc: '',
      args: [],
    );
  }

  /// `Street and number`
  String get address {
    return Intl.message(
      'Street and number',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Postal code`
  String get postalCode {
    return Intl.message(
      'Postal code',
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
  String get missingStreetNumber {
    return Intl.message(
      'Please input your street and number.',
      name: 'missingStreetNumber',
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
