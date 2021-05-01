import 'package:flutter_bloc/flutter_bloc.dart';

import 'createDidEvent.dart';
import 'createDidState.dart';
import 'formSubmissionStatus.dart';
import '../../data/createDidRepository.dart';

class CreateDidBloc extends Bloc<CreateDidEvent, CreateDidState> {
  CreateDidBloc({required this.repo}) : super(CreateDidState());
  final CreateDidRepository repo;

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
      print(event.country);
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
        print(res.message);
        if (res.success == true) {
          yield state.copyWith(formStatus: SubmissionSuccess(res, res.message));
        } else {
          yield state.copyWith(formStatus: SubmissionFailed(res.message));
        }
      } catch (e) {
        print(e);
        //TODO: figure out why this catch returns Object instead of exception
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
    }
  }
}
