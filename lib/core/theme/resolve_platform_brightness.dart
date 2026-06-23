import "package:flutter/widgets.dart";

Brightness resolvePlatformBrightness() {
  return WidgetsBinding.instance.platformDispatcher.platformBrightness;
}
