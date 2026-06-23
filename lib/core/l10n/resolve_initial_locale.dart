import "package:flutter/material.dart";

import "locale_storage.dart";

Locale resolveInitialLocale(LocaleStorage localeStorage) {
  final locale = localeStorage.getLocale();
  return locale ?? WidgetsBinding.instance.platformDispatcher.locale;
}
