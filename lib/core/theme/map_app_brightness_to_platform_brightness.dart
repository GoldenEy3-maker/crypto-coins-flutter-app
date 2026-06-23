import "package:flutter/material.dart";

import "package:flutter_application_1/core/theme/app_brightness.dart";
import "resolve_platform_brightness.dart";

Brightness mapAppBrightnessToPlatformBrightness(AppBrightness brightness) {
  return switch (brightness) {
    AppBrightness.light => Brightness.light,
    AppBrightness.dark => Brightness.dark,
    AppBrightness.system => resolvePlatformBrightness(),
  };
}
