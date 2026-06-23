import "package:flutter/material.dart";

class Language {
  final String name;
  final Locale locale;

  const Language({required this.name, required this.locale});

  static List<Language> languageList() {
    return [
      const Language(name: "Русский", locale: Locale("ru")),
      const Language(name: "English", locale: Locale("en")),
    ];
  }

  static Language fromLocale(Locale locale) {
    return languageList().firstWhere(
      (language) => language.locale.languageCode == locale.languageCode,
      orElse: () => languageList().first,
    );
  }
}
