import 'package:did/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences _preferences;

Future sharedPreferencesInit() async =>
    _preferences = await SharedPreferences.getInstance();

Future changeLanguage(String language) =>
    _preferences.setString("language", language);

String getLanguage() => _preferences.getString("language") ?? "en";

Future changeTheme(AppTheme theme) {
  final themeString = theme == AppTheme.light ? "light" : "dark";
  return _preferences.setString("theme", themeString);
}

AppTheme getTheme() {
  final theme = _preferences.getString("theme") ?? "light";
  if (theme == "light") {
    return AppTheme.light;
  } else if (theme == "dark") {
    return AppTheme.dark;
  } else {
    return AppTheme.light;
  }
}
