import "package:flutter/material.dart";

import "locale_storage.dart";

class LocaleProvider extends ChangeNotifier {
  final LocaleStorage localeStorage;
  Locale _locale;

  LocaleProvider({required this.localeStorage, required Locale locale})
    : _locale = locale;

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (_locale == locale) return;
    _locale = locale;
    localeStorage.setLocale(locale);
    notifyListeners();
  }
}
