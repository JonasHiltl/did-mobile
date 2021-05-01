class LanguageState {
  //TODO: set initial language to language stored in hive
  LanguageState({required this.language});
  final String language;

  LanguageState copyWith({
    String? language,
  }) {
    return LanguageState(language: language ?? this.language);
  }
}
