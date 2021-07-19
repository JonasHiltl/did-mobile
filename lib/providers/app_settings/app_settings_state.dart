import 'package:did/theme.dart';

class AppSettingsState {
  final String language;
  final AppTheme themeData;

  AppSettingsState({required this.language, required this.themeData});

  AppSettingsState copyWith({
    String? language,
    AppTheme? themeData,
  }) {
    return AppSettingsState(
      language: language ?? this.language,
      themeData: themeData ?? this.themeData,
    );
  }
}
