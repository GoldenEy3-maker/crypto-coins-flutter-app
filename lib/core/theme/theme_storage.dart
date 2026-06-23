import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

class ThemeStorage {
  final SharedPreferences prefs;
  final _key = "theme";

  ThemeStorage({required this.prefs});

  Brightness? getTheme() {
    final theme = prefs.getString(_key);
    return theme != null ? Brightness.values.byName(theme) : null;
  }

  Future<bool> setTheme(Brightness brightness) {
    return prefs.setString(_key, brightness.name);
  }

  Future<bool> clearTheme() {
    return prefs.remove(_key);
  }
}
