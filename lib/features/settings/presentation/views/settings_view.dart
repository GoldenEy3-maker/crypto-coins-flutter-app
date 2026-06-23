import "package:flutter/material.dart";
import "package:flutter_application_1/core/logging/talker_screen.dart";
import "package:flutter_application_1/core/theme/app_brightness_theme_label_resolver.dart";
import "package:flutter_application_1/core/theme/theme_provider.dart";
import "package:flutter_application_1/core/l10n/language.dart";
import "package:flutter_application_1/features/settings/presentation/widgets/change_locale_bottom_sheet.dart";
import "package:flutter_application_1/features/settings/presentation/widgets/change_theme_bottom_sheet.dart";
import "package:flutter_application_1/core/l10n/locale_provider.dart";
import "package:talker_flutter/talker_flutter.dart";

class SettingsView extends StatelessWidget {
  final ThemeProvider themeProvider;
  final LocaleProvider localeProvider;
  final Talker talker;

  const SettingsView({
    super.key,
    required this.themeProvider,
    required this.localeProvider,
    required this.talker,
  });

  void _openThemePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ChangeThemeBottomSheet(themeProvider: themeProvider);
      },
    );
  }

  void _openLocalePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ChangeLocaleBottomSheet(localeProvider: localeProvider);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBrightnessThemeLabelResolver =
        AppBrightnessThemeLabelResolver.fromContext(context);

    return CustomScrollView(
      slivers: [
        SliverList.list(
          children: [
            Card(
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
              ).copyWith(bottom: 8),
              child: ListTile(
                onTap: () => _openThemePicker(context),
                title: const Text("Тема"),
                trailing: ListenableBuilder(
                  listenable: themeProvider,
                  builder: (context, _) {
                    return Text(
                      appBrightnessThemeLabelResolver.resolve(
                        themeProvider.theme,
                      ),
                      style: const TextStyle(fontSize: 16),
                    );
                  },
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: ListTile(
                onTap: () => _openLocalePicker(context),
                title: const Text("Язык"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      Language.fromLocale(localeProvider.locale).name,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: ListTile(
                leading: const Icon(Icons.bug_report),
                title: const Text("Дебаггер"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CustomTalkerScreen(talker: talker),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
