import 'dart:convert';

import 'package:did/models/did/identity.dart';
import 'package:did/providers/appScreenState/authFlow/authCubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/secureStorage.dart';
import 'form_submission_status.dart';
import 'repository/update_personal_data_repo.dart';
import 'update_personal_event.dart';
import 'update_personal_state.dart';

class UpdatePersonalBloc
    extends Bloc<UpdatePersonalEvent, UpdatePersonalState> {
  //I'm passing these values inside the class to define the initial values of the already created VC to update them afterwards
  UpdatePersonalBloc({
    required this.repo,
    required this.authCubit,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.sex,
    required this.address,
    required this.city,
    required this.locationState,
    required this.postalCode,
    required this.country,
  }) : super(UpdatePersonalState(
          firstName: firstName,
          lastName: lastName,
          email: email,
          phoneNumber: phoneNumber,
          dateOfBirth: dateOfBirth,
          sex: sex,
          address: address,
          city: city,
          state: locationState,
          postalCode: postalCode,
          country: country,
        ));

  final UpdatePersonalDataRepo repo;
  final AuthCubit authCubit;
  final SecureStorage secureStorage = SecureStorage();

  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final DateTime dateOfBirth;
  final String sex;
  final String address;
  final String city;
  final String locationState;
  final String postalCode;
  final String country;

  @override
  Stream<UpdatePersonalState> mapEventToState(
      UpdatePersonalEvent event) async* {
    if (event is UpdatePersonalFirstNameChanged) {
      print("First Name changed: ${event.firstName}");
      yield state.copyWith(firstname: event.firstName);
    } else if (event is UpdatePersonalLastNameChanged) {
      print("Last Name changed: ${event.lastName}");
      yield state.copyWith(lastName: event.lastName);
    } else if (event is UpdatePersonalEmailChanged) {
      print("Email changed: ${event.email}");
      yield state.copyWith(email: event.email);
    } else if (event is UpdatePersonalPhoneNumberChanged) {
      print("phoneNumber changed: ${event.phoneNumber}");
      yield state.copyWith(phoneNumber: event.phoneNumber);
    } else if (event is UpdatePersonalDateOfBirthChanged) {
      print("dateOfBirth changed: ${event.dateOfBirth}");
      yield state.copyWith(dateOfBirth: event.dateOfBirth);
    } else if (event is UpdatePersonalSexChanged) {
      print("Sex changed: ${event.sex}");
      yield state.copyWith(sex: event.sex);
    } else if (event is UpdatePersonalAddressChanged) {
      print("Address changed: ${event.address}");
      yield state.copyWith(address: event.address);
    } else if (event is UpdatePersonalCityChanged) {
      yield state.copyWith(city: event.city);
    } else if (event is UpdatePersonalStateChanged) {
      yield state.copyWith(state: event.state);
    } else if (event is UpdatePersonalPostalCodeChanged) {
      yield state.copyWith(postalCode: event.postalCode);
    } else if (event is UpdatePersonalCountryChanged) {
      print("Country changed: ${event.country}");
      yield state.copyWith(country: event.country);
    } else if (event is UpdatePersonalSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        final res = await repo.createDid(
            state.firstName,
            state.lastName,
            state.email,
            state.phoneNumber,
            state.dateOfBirth,
            state.sex,
            state.address,
            state.city,
            state.state,
            state.postalCode,
            state.country);
        if (res.id.isNotEmpty) {
          await secureStorage.write("personal_data_vc", jsonEncode(res));

          final encodedIdentity = await secureStorage.read("identity");
          final decodedDid =
              jsonDecode(encodedIdentity.toString()) as Map<String, dynamic>;
          final identity = Identity.fromJson(decodedDid);

          yield state.copyWith(formStatus: SubmissionSuccess());
          yield state.copyWith(formStatus: const InitialFormStatus());

          // launch the session flow with the returned Did object
          authCubit.launchSession(identity, res);
        } else {
          yield state.copyWith(
              formStatus: SubmissionFailed("Backend error creating Did"));
          yield state.copyWith(formStatus: const InitialFormStatus());
        }
      } catch (e) {
        print(e);
        yield state.copyWith(formStatus: SubmissionFailed(e));
        //yield initial state to counter the reappearing of noti after state changes (For example when keyboard gets closed or input changes)
        yield state.copyWith(formStatus: const InitialFormStatus());
      }
    }
  }
}
