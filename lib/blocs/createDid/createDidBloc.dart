import 'dart:convert';

import 'package:did/blocs/appScreenState/authFlow/authCubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/createDidRepository.dart';
import '../../data/secureStorage.dart';
import 'createDidEvent.dart';
import 'createDidState.dart';
import 'formSubmissionStatus.dart';

class CreateDidBloc extends Bloc<CreateDidEvent, CreateDidState> {
  CreateDidBloc({required this.repo, required this.authCubit})
      : super(CreateDidState());
  final CreateDidRepository repo;
  final AuthCubit authCubit;
  final SecureStorage secureStorage = SecureStorage();

  @override
  Stream<CreateDidState> mapEventToState(CreateDidEvent event) async* {
    if (event is CreateDidFirstNameChanged) {
      yield state.copyWith(firstname: event.firstName);
    } else if (event is CreateDidLastNameChanged) {
      yield state.copyWith(lastName: event.lastName);
    } else if (event is CreateDidEmailChanged) {
      yield state.copyWith(email: event.email);
    } else if (event is CreateDidPhoneNumberChanged) {
      yield state.copyWith(phoneNumber: event.phoneNumber);
    } else if (event is CreateDidDateOfBirthChanged) {
      yield state.copyWith(dateOfBirth: event.dateOfBirth);
    } else if (event is CreateDidSexChanged) {
      yield state.copyWith(sex: event.sex);
    } else if (event is CreateDidAddressChanged) {
      yield state.copyWith(address: event.address);
    } else if (event is CreateDidCityChanged) {
      yield state.copyWith(city: event.city);
    } else if (event is CreateDidStateChanged) {
      yield state.copyWith(state: event.state);
    } else if (event is CreateDidPostalCodeChanged) {
      yield state.copyWith(postalCode: event.postalCode);
    } else if (event is CreateDidCountryChanged) {
      yield state.copyWith(country: event.country);
    } else if (event is CreateDidSubmitted) {
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
        if (res.credential.id.isNotEmpty) {
          await secureStorage.write("did", jsonEncode(res));
          final savedId = await secureStorage.read("did");

          print(savedId);
          yield state.copyWith(formStatus: SubmissionSuccess(res));

          // launch the session flow with the returned Did object
          authCubit.launchSession(res);
        } else {
          yield state.copyWith(
              formStatus: SubmissionFailed("Backend error creating Did"));
        }
      } catch (e) {
        print(e);
        //TODO: figure out why this catch returns Object instead of exception
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
    }
  }
}
