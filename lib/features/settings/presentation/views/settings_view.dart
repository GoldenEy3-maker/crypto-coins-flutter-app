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
  final ThemeProvider _themeProvider;
  final LocaleProvider _localeProvider;
  final Talker _talker;
  final String _userEmail;
  final bool _isAuthLoading;
  final void Function() _onLogout;

  const SettingsView({
    super.key,
    required ThemeProvider themeProvider,
    required LocaleProvider localeProvider,
    required Talker talker,
    required String userEmail,
    required void Function() onLogout,
    required bool isAuthLoading,
  }) : _themeProvider = themeProvider,
       _localeProvider = localeProvider,
       _talker = talker,
       _userEmail = userEmail,
       _onLogout = onLogout,
       _isAuthLoading = isAuthLoading;

  void _openThemePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ChangeThemeBottomSheet(themeProvider: _themeProvider);
      },
    );
  }

  void _openLocalePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ChangeLocaleBottomSheet(localeProvider: _localeProvider);
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
                onTap: _onLogout,
                title: Text(_userEmail),
                subtitle: const Text("Выйти"),
                trailing: _isAuthLoading
                    ? const CircularProgressIndicator()
                    : const Icon(Icons.logout),
                enabled: _userEmail.isNotEmpty,
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
              ).copyWith(bottom: 8),
              child: ListTile(
                onTap: () => _openThemePicker(context),
                title: const Text("Тема"),
                trailing: ListenableBuilder(
                  listenable: _themeProvider,
                  builder: (context, _) {
                    return Text(
                      appBrightnessThemeLabelResolver.resolve(
                        _themeProvider.theme,
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
                      Language.fromLocale(_localeProvider.locale).name,
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
                      builder: (context) => CustomTalkerScreen(talker: _talker),
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
