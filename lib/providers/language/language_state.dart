class LanguageState {
  LanguageState({required this.language});
  final String language;

  LanguageState copyWith({
    String? language,
  }) {
    return LanguageState(language: language ?? this.language);
  }
}
