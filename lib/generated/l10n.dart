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

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
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

  /// `Sex`
  String get simpleSex {
    return Intl.message(
      'Sex',
      name: 'simpleSex',
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

  /// `Allergies`
  String get allergies {
    return Intl.message(
      'Allergies',
      name: 'allergies',
      desc: '',
      args: [],
    );
  }

  /// `Allergy`
  String get allergy {
    return Intl.message(
      'Allergy',
      name: 'allergy',
      desc: '',
      args: [],
    );
  }

  /// `Medication`
  String get medication {
    return Intl.message(
      'Medication',
      name: 'medication',
      desc: '',
      args: [],
    );
  }

  /// `Symptom`
  String get symptom {
    return Intl.message(
      'Symptom',
      name: 'symptom',
      desc: '',
      args: [],
    );
  }

  /// `Symptoms`
  String get symptoms {
    return Intl.message(
      'Symptoms',
      name: 'symptoms',
      desc: '',
      args: [],
    );
  }

  /// `Condition`
  String get condition {
    return Intl.message(
      'Condition',
      name: 'condition',
      desc: '',
      args: [],
    );
  }

  /// `Frequency`
  String get frequency {
    return Intl.message(
      'Frequency',
      name: 'frequency',
      desc: '',
      args: [],
    );
  }

  /// `Dose`
  String get dose {
    return Intl.message(
      'Dose',
      name: 'dose',
      desc: '',
      args: [],
    );
  }

  /// `Issued `
  String get issued {
    return Intl.message(
      'Issued ',
      name: 'issued',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Medication`
  String get pluralMedication {
    return Intl.message(
      'Medication',
      name: 'pluralMedication',
      desc: '',
      args: [],
    );
  }

  /// `Personal Information Credential`
  String get personalInfoVC {
    return Intl.message(
      'Personal Information Credential',
      name: 'personalInfoVC',
      desc: '',
      args: [],
    );
  }

  /// `Patient Questionnaire`
  String get patientQuestionnaire {
    return Intl.message(
      'Patient Questionnaire',
      name: 'patientQuestionnaire',
      desc: '',
      args: [],
    );
  }

  /// `Add Allergy`
  String get addAllergy {
    return Intl.message(
      'Add Allergy',
      name: 'addAllergy',
      desc: '',
      args: [],
    );
  }

  /// `Add Medication`
  String get addMedication {
    return Intl.message(
      'Add Medication',
      name: 'addMedication',
      desc: '',
      args: [],
    );
  }

  /// `e.g. Pollen`
  String get examplePollen {
    return Intl.message(
      'e.g. Pollen',
      name: 'examplePollen',
      desc: '',
      args: [],
    );
  }

  /// `e.g. Sneezing`
  String get exampleSneezing {
    return Intl.message(
      'e.g. Sneezing',
      name: 'exampleSneezing',
      desc: '',
      args: [],
    );
  }

  /// `e.g. Aspirin`
  String get exampleAspirin {
    return Intl.message(
      'e.g. Aspirin',
      name: 'exampleAspirin',
      desc: '',
      args: [],
    );
  }

  /// `e.g. Headaches`
  String get exampleHeadaches {
    return Intl.message(
      'e.g. Headaches',
      name: 'exampleHeadaches',
      desc: '',
      args: [],
    );
  }

  /// `e.g. once daily`
  String get exampleOnceDaily {
    return Intl.message(
      'e.g. once daily',
      name: 'exampleOnceDaily',
      desc: '',
      args: [],
    );
  }

  /// `e.g. 75 mg`
  String get example75mg {
    return Intl.message(
      'e.g. 75 mg',
      name: 'example75mg',
      desc: '',
      args: [],
    );
  }

  /// `You can only edit this data in settings`
  String get editProfile {
    return Intl.message(
      'You can only edit this data in settings',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Do you have any allergies?`
  String get anyAllergies {
    return Intl.message(
      'Do you have any allergies?',
      name: 'anyAllergies',
      desc: '',
      args: [],
    );
  }

  /// `Do you take any medication?`
  String get anyMedication {
    return Intl.message(
      'Do you take any medication?',
      name: 'anyMedication',
      desc: '',
      args: [],
    );
  }

  /// `Create Patient Questionnaire`
  String get createPQ {
    return Intl.message(
      'Create Patient Questionnaire',
      name: 'createPQ',
      desc: '',
      args: [],
    );
  }

  /// `Give your patient Questionnaire a name!`
  String get givePQName {
    return Intl.message(
      'Give your patient Questionnaire a name!',
      name: 'givePQName',
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

  /// `Digital Identity successfully created`
  String get createSuccessMessage {
    return Intl.message(
      'Digital Identity successfully created',
      name: 'createSuccessMessage',
      desc: '',
      args: [],
    );
  }

  /// `Your digital identity creation failed`
  String get createErrorMessage {
    return Intl.message(
      'Your digital identity creation failed',
      name: 'createErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Patient Questionnaire successfully created`
  String get createPQSuccessMessage {
    return Intl.message(
      'Patient Questionnaire successfully created',
      name: 'createPQSuccessMessage',
      desc: '',
      args: [],
    );
  }

  /// `Your Patient Questionnaire creation failed`
  String get createPQErrorMessage {
    return Intl.message(
      'Your Patient Questionnaire creation failed',
      name: 'createPQErrorMessage',
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

  /// `No allergies added yet`
  String get noAllergiesAddedYet {
    return Intl.message(
      'No allergies added yet',
      name: 'noAllergiesAddedYet',
      desc: '',
      args: [],
    );
  }

  /// `No allergies added`
  String get noAllergiesAdded {
    return Intl.message(
      'No allergies added',
      name: 'noAllergiesAdded',
      desc: '',
      args: [],
    );
  }

  /// `No medication added yet`
  String get noMedicationAddedYet {
    return Intl.message(
      'No medication added yet',
      name: 'noMedicationAddedYet',
      desc: '',
      args: [],
    );
  }

  /// `No medication added`
  String get noMedicationAdded {
    return Intl.message(
      'No medication added',
      name: 'noMedicationAdded',
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

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Delete Data`
  String get deleteData {
    return Intl.message(
      'Delete Data',
      name: 'deleteData',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to irrevocably delete all of your data?`
  String get confirmDataDeletion {
    return Intl.message(
      'Are you sure to irrevocably delete all of your data?',
      name: 'confirmDataDeletion',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get changeLanguage {
    return Intl.message(
      'Change Language',
      name: 'changeLanguage',
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

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Delete all data`
  String get deleteAll {
    return Intl.message(
      'Delete all data',
      name: 'deleteAll',
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

  /// `Aktualisierung deiner persönlichen Daten fehlgeschlagen`
  String get updateErrorMessage {
    return Intl.message(
      'Aktualisierung deiner persönlichen Daten fehlgeschlagen',
      name: 'updateErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `First name has been updated`
  String get updateSuccessFirstName {
    return Intl.message(
      'First name has been updated',
      name: 'updateSuccessFirstName',
      desc: '',
      args: [],
    );
  }

  /// `Last name has been updated`
  String get updateSuccessLastName {
    return Intl.message(
      'Last name has been updated',
      name: 'updateSuccessLastName',
      desc: '',
      args: [],
    );
  }

  /// `Email has been updated`
  String get updateSuccessEmail {
    return Intl.message(
      'Email has been updated',
      name: 'updateSuccessEmail',
      desc: '',
      args: [],
    );
  }

  /// `Phone number has been updated`
  String get updateSuccessPhoneNumber {
    return Intl.message(
      'Phone number has been updated',
      name: 'updateSuccessPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Date of Birth has been updated`
  String get updateSuccessDateOfBirth {
    return Intl.message(
      'Date of Birth has been updated',
      name: 'updateSuccessDateOfBirth',
      desc: '',
      args: [],
    );
  }

  /// `Biological sex has been updated`
  String get updateSuccessSex {
    return Intl.message(
      'Biological sex has been updated',
      name: 'updateSuccessSex',
      desc: '',
      args: [],
    );
  }

  /// `Address has been updated`
  String get updateSuccessAddress {
    return Intl.message(
      'Address has been updated',
      name: 'updateSuccessAddress',
      desc: '',
      args: [],
    );
  }

  /// `City has been updated`
  String get updateSuccessCity {
    return Intl.message(
      'City has been updated',
      name: 'updateSuccessCity',
      desc: '',
      args: [],
    );
  }

  /// `State has been updated`
  String get updateSuccessState {
    return Intl.message(
      'State has been updated',
      name: 'updateSuccessState',
      desc: '',
      args: [],
    );
  }

  /// `Postal code has been updated`
  String get updateSuccessPostalCode {
    return Intl.message(
      'Postal code has been updated',
      name: 'updateSuccessPostalCode',
      desc: '',
      args: [],
    );
  }

  /// `Country has been updated`
  String get updateSuccessCountry {
    return Intl.message(
      'Country has been updated',
      name: 'updateSuccessCountry',
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
