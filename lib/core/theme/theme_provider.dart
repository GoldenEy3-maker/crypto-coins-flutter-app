import "package:flutter/foundation.dart";
import "package:flutter_application_1/core/theme/app_brightness.dart";
import "map_app_brightness_to_platform_brightness.dart";
import "map_platform_brightness_to_app_brightness.dart";
import "resolve_platform_brightness.dart";
import "theme_storage.dart";

class ThemeProvider extends ChangeNotifier {
  final ThemeStorage themeStorage;
  late AppBrightness _theme;
  late Brightness _resolvedTheme;

  ThemeProvider({required this.themeStorage}) {
    final savedTheme = themeStorage.getTheme();
    final resolvedPlatformBrightness = resolvePlatformBrightness();
    _theme = savedTheme != null
        ? mapPlatformBrightnessToAppBrightness(savedTheme)
        : AppBrightness.system;
    _resolvedTheme = savedTheme ?? resolvedPlatformBrightness;
  }

  AppBrightness get theme => _theme;
  Brightness get resolvedTheme => _resolvedTheme;

  bool get isDark => _resolvedTheme == Brightness.dark;

  void setTheme(AppBrightness brightness) {
    if (_theme == brightness) return;

    if (brightness == AppBrightness.system) {
      _setSystemTheme();
      return;
    }

    _theme = brightness;

    final platformBrightness = mapAppBrightnessToPlatformBrightness(brightness);
    _resolvedTheme = platformBrightness;
    themeStorage.setTheme(platformBrightness);

    notifyListeners();
  }

  void _setSystemTheme() {
    themeStorage.clearTheme();
    _theme = AppBrightness.system;
    _resolvedTheme = resolvePlatformBrightness();
    notifyListeners();
  }

  void setResolvedTheme(Brightness brightness) {
    if (_resolvedTheme == brightness) return;

    _resolvedTheme = brightness;
    notifyListeners();
  }
}
