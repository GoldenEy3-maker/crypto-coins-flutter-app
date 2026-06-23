import "package:flutter/widgets.dart";
import "package:flutter_application_1/core/l10n/app_localizations.dart";

import "package:flutter_application_1/core/theme/app_brightness.dart";

class AppBrightnessThemeLabelResolver {
  final AppLocalizations appLocalizations;

  AppBrightnessThemeLabelResolver({required this.appLocalizations});

  AppBrightnessThemeLabelResolver.fromContext(BuildContext context)
    : appLocalizations = AppLocalizations.of(context)!;

  String resolve(AppBrightness brightness) {
    return switch (brightness) {
      AppBrightness.light => appLocalizations.lightTheme,
      AppBrightness.dark => appLocalizations.darkTheme,
      AppBrightness.system => appLocalizations.systemTheme,
    };
  }
}
