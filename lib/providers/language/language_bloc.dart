import 'package:flutter_bloc/flutter_bloc.dart';
import 'language_event.dart';
import 'language_state.dart';
import 'storage_utils.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc(String language) : super(LanguageState(language: language));

  @override
  Stream<LanguageState> mapEventToState(LanguageEvent event) async* {
    if (event is LanguageChanged) {
      LanguagePreference.changeLanguage(event.language);
      yield state.copyWith(language: event.language);
    }
  }
}
