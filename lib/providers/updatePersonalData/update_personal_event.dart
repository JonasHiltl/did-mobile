abstract class UpdatePersonalEvent {}

class UpdatePersonalFirstNameChanged extends UpdatePersonalEvent {
  UpdatePersonalFirstNameChanged({required this.firstName});

  final String firstName;
}

class UpdatePersonalLastNameChanged extends UpdatePersonalEvent {
  UpdatePersonalLastNameChanged({required this.lastName});

  final String lastName;
}

class UpdatePersonalEmailChanged extends UpdatePersonalEvent {
  UpdatePersonalEmailChanged({required this.email});

  final String email;
}

class UpdatePersonalPhoneNumberChanged extends UpdatePersonalEvent {
  UpdatePersonalPhoneNumberChanged({required this.phoneNumber});

  final String phoneNumber;
}

class UpdatePersonalDateOfBirthChanged extends UpdatePersonalEvent {
  UpdatePersonalDateOfBirthChanged({required this.dateOfBirth});

  final DateTime dateOfBirth;
}

class UpdatePersonalSexChanged extends UpdatePersonalEvent {
  UpdatePersonalSexChanged({required this.sex});

  final String sex;
}

class UpdatePersonalAddressChanged extends UpdatePersonalEvent {
  UpdatePersonalAddressChanged({required this.address});

  final String address;
}

class UpdatePersonalCityChanged extends UpdatePersonalEvent {
  UpdatePersonalCityChanged({required this.city});

  final String city;
}

class UpdatePersonalStateChanged extends UpdatePersonalEvent {
  UpdatePersonalStateChanged({required this.state});

  final String state;
}

class UpdatePersonalPostalCodeChanged extends UpdatePersonalEvent {
  UpdatePersonalPostalCodeChanged({required this.postalCode});

  final String postalCode;
}

class UpdatePersonalCountryChanged extends UpdatePersonalEvent {
  UpdatePersonalCountryChanged({required this.country});

  final String country;
}

class UpdatePersonalSubmitted extends UpdatePersonalEvent {}
