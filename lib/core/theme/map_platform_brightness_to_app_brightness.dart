import "dart:ui";

import "package:flutter_application_1/core/theme/app_brightness.dart";

AppBrightness mapPlatformBrightnessToAppBrightness(Brightness brightness) {
  return switch (brightness) {
    Brightness.light => AppBrightness.light,
    Brightness.dark => AppBrightness.dark,
  };
}
