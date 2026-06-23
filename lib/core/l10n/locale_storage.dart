import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

class LocaleStorage {
  final SharedPreferences _prefs;
  final _key = "locale";

  LocaleStorage({required SharedPreferences prefs}) : _prefs = prefs;

  Future<bool> setLocale(Locale locale) {
    return _prefs.setString(_key, locale.languageCode);
  }

  Locale? getLocale() {
    final languageCode = _prefs.getString(_key);
    return languageCode != null ? Locale(languageCode) : null;
  }
}
