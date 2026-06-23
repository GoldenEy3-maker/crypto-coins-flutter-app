import "package:flutter/material.dart";
import "package:flutter_application_1/core/di/get_it.dart";
import "package:flutter_application_1/app/router/app_router.dart";
import "package:flutter_application_1/core/theme/app_theme.dart";
import "package:flutter_application_1/core/theme/theme_provider.dart";
import "package:flutter_application_1/core/l10n/app_localizations.dart";
import "package:flutter_application_1/core/l10n/locale_provider.dart";
import "package:talker_flutter/talker_flutter.dart";

class CoinsApp extends StatefulWidget {
  const CoinsApp({super.key});

  @override
  State<CoinsApp> createState() => _CoinsAppState();
}

class _CoinsAppState extends State<CoinsApp> with WidgetsBindingObserver {
  final appRouter = getIt.get<AppRouter>();
  final localeProvider = getIt.get<LocaleProvider>();
  final themeProvider = getIt.get<ThemeProvider>();
  final appTheme = getIt.get<AppTheme>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    themeProvider.setResolvedTheme(
      WidgetsBinding.instance.platformDispatcher.platformBrightness,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([localeProvider, themeProvider]),
      builder: (context, child) {
        final theme = themeProvider.isDark
            ? appTheme.darkTheme
            : appTheme.lightTheme;

        return MaterialApp.router(
          title: "Coins App",
          locale: localeProvider.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: theme,
          routerConfig: appRouter.config(
            navigatorObservers: () => [
              TalkerRouteObserver(getIt.get<Talker>()),
            ],
          ),
        );
      },
    );
  }
}
