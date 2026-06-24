import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_application_1/core/di/get_it.dart";
import "package:flutter_application_1/core/l10n/app_localizations.dart";
import "package:flutter_application_1/features/settings/presentation/views/settings_view.dart";
import "package:flutter_application_1/core/l10n/locale_provider.dart";
import "package:flutter_application_1/core/theme/theme_provider.dart";
import "package:talker_flutter/talker_flutter.dart";

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final i10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(i10n.bottomNavigationBarSettings)),
      body: SettingsView(
        themeProvider: getIt.get<ThemeProvider>(),
        localeProvider: getIt.get<LocaleProvider>(),
        talker: getIt.get<Talker>(),
      ),
    );
  }
}
