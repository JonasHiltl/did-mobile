import '../../theme.dart';

abstract class AppSettingsEvent {}

class LanguageChanged extends AppSettingsEvent {
  final String language;

  LanguageChanged({required this.language});
}

class ThemeChanged extends AppSettingsEvent {
  final AppTheme theme;

  ThemeChanged({required this.theme});
}
