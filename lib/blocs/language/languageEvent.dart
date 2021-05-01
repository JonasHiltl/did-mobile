abstract class LanguageEvent {}

class LanguageChanged extends LanguageEvent {
  LanguageChanged({required this.language});

  final String language;
}
