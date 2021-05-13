abstract class CreateDidEvent {}

class CreateDidFirstNameChanged extends CreateDidEvent {
  CreateDidFirstNameChanged({required this.firstName});

  final String firstName;
}

class CreateDidLastNameChanged extends CreateDidEvent {
  CreateDidLastNameChanged({required this.lastName});

  final String lastName;
}

class CreateDidEmailChanged extends CreateDidEvent {
  CreateDidEmailChanged({required this.email});

  final String email;
}

class CreateDidPhoneNumberChanged extends CreateDidEvent {
  CreateDidPhoneNumberChanged({required this.phoneNumber});

  final String phoneNumber;
}

class CreateDidDateOfBirthChanged extends CreateDidEvent {
  CreateDidDateOfBirthChanged({required this.dateOfBirth});

  final DateTime dateOfBirth;
}

class CreateDidSexChanged extends CreateDidEvent {
  CreateDidSexChanged({required this.sex});

  final String sex;
}

class CreateDidAddressChanged extends CreateDidEvent {
  CreateDidAddressChanged({required this.address});

  final String address;
}

class CreateDidCityChanged extends CreateDidEvent {
  CreateDidCityChanged({required this.city});

  final String city;
}

class CreateDidStateChanged extends CreateDidEvent {
  CreateDidStateChanged({required this.state});

  final String state;
}

class CreateDidPostalCodeChanged extends CreateDidEvent {
  CreateDidPostalCodeChanged({required this.postalCode});

  final String postalCode;
}

class CreateDidCountryChanged extends CreateDidEvent {
  CreateDidCountryChanged({required this.country});

  final String country;
}

class CreateDidSubmitted extends CreateDidEvent {}
