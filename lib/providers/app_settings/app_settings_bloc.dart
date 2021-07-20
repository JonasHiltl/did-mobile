import 'package:flutter_bloc/flutter_bloc.dart';

import '../../theme.dart';
import 'app_settings_event.dart';
import 'app_settings_state.dart';
import 'app_settings_storage.dart';

class AppSettingsBloc extends Bloc<AppSettingsEvent, AppSettingsState> {
  AppSettingsBloc({
    required String language,
    required AppTheme theme,
    required bool useTouchID,
  }) : super(
          AppSettingsState(
            language: language,
            themeData: theme,
            useTouchID: useTouchID,
          ),
        );

  @override
  Stream<AppSettingsState> mapEventToState(AppSettingsEvent event) async* {
    if (event is LanguageChanged) {
      changeLanguage(event.language);
      yield state.copyWith(language: event.language);
    }
    if (event is ThemeChanged) {
      changeTheme(event.theme);
      yield state.copyWith(themeData: event.theme);
    }
    if (event is TouchIDChanged) {
      changeUseTouchID(event.useTouchID);
      yield state.copyWith(useTouchID: event.useTouchID);
    }
  }
}
