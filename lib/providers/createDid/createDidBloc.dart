import 'dart:convert';

import 'package:did/providers/appScreenState/authFlow/authCubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/secureStorage.dart';
import 'createDidEvent.dart';
import 'createDidState.dart';
import 'formSubmissionStatus.dart';
import 'repo/createDidRepository.dart';

class CreateDidBloc extends Bloc<CreateDidEvent, CreateDidState> {
  final CreateDidRepository repo;
  final AuthCubit authCubit;
  final SecureStorage secureStorage = SecureStorage();

  CreateDidBloc({required this.repo, required this.authCubit})
      : super(CreateDidState());

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
        if (res.personalDataVc.id.isNotEmpty) {
          await secureStorage.write("identity", jsonEncode(res.identity));
          await secureStorage.write(
              "personal_data_vc", jsonEncode(res.personalDataVc));

          yield state.copyWith(formStatus: SubmissionSuccess());
          yield state.copyWith(formStatus: const InitialFormStatus());

          // launch the session flow with the returned Did object
          authCubit.launchSession(res.identity, res.personalDataVc);
        } else {
          yield state.copyWith(
              formStatus: SubmissionFailed("Backend error creating Did"));
          yield state.copyWith(formStatus: const InitialFormStatus());
        }
      } catch (e) {
        print(e);
        yield state.copyWith(formStatus: SubmissionFailed(e.toString()));
        //yield initial state to counter the reappearing of noti after state changes (For example when keyboard gets closed or input changes)
        yield state.copyWith(formStatus: const InitialFormStatus());
      }
    }
  }
}
