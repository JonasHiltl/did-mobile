//TODO: all functions that CRUD the local database put it in this file
import 'package:shared_preferences/shared_preferences.dart';

class LanguagePreference {
  static late SharedPreferences _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future changeLanguage(String language) =>
      _preferences.setString("language", language);

  static String getLanguage() => _preferences.getString("language") ?? "en";
}
