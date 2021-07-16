import 'package:flutter/material.dart';

class AppSettingsState {
  final String language;
  final ThemeData themeData;

  AppSettingsState({required this.language, required this.themeData});

  AppSettingsState copyWith({
    String? language,
    ThemeData? themeData,
  }) {
    return AppSettingsState(
      language: language ?? this.language,
      themeData: themeData ?? this.themeData,
    );
  }
}
