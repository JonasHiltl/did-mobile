import 'package:did/theme.dart';

class AppSettingsState {
  final String language;
  final AppTheme themeData;
  bool useTouchID = false;

  AppSettingsState({
    required this.language,
    required this.themeData,
    required this.useTouchID,
  });

  AppSettingsState copyWith({
    String? language,
    AppTheme? themeData,
    bool? useTouchID,
  }) {
    return AppSettingsState(
      language: language ?? this.language,
      themeData: themeData ?? this.themeData,
      useTouchID: useTouchID ?? this.useTouchID,
    );
  }
}
