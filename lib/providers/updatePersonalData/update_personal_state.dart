import 'form_submission_status.dart';

final RegExp _emailRegExp = RegExp(
  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
);

class UpdatePersonalState {
  UpdatePersonalState({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.sex,
    required this.address,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.formStatus = const InitialFormStatus(),
  });

  final String firstName;
  bool get isValidFirstName => firstName.isNotEmpty;
  final String lastName;
  bool get isValidlastName => lastName.isNotEmpty;
  final String email;
  bool get isValidEmail => email.isNotEmpty && _emailRegExp.hasMatch(email);
  bool get showEmailError => email.isNotEmpty && !_emailRegExp.hasMatch(email);
  final String phoneNumber;
  bool get isValidPhoneNumber => phoneNumber.isNotEmpty;
  final DateTime? dateOfBirth;
  bool get isValidDateOfBirth => dateOfBirth is DateTime;
  final String sex;
  bool get isValidSex => sex.isNotEmpty;
  final String address;
  bool get isValidAddress => address.isNotEmpty;
  final String city;
  bool get isValidCity => city.isNotEmpty;
  final String state;
  bool get isValidState => state.isNotEmpty;
  final String postalCode;
  bool get isValidPostalCode => postalCode.isNotEmpty;
  final String country;
  bool get isValidCountry => country.isNotEmpty;
  final FormSubmissionStatus formStatus;

  UpdatePersonalState copyWith({
    String? firstname,
    String? lastName,
    String? email,
    String? phoneNumber,
    DateTime? dateOfBirth,
    String? sex,
    String? address,
    String? city,
    String? state,
    String? postalCode,
    String? country,
    FormSubmissionStatus? formStatus,
  }) {
    return UpdatePersonalState(
      firstName: firstname ?? firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      sex: sex ?? this.sex,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
