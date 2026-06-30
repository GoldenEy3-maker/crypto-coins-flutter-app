import "package:flutter/material.dart";
import "package:flutter_application_1/core/di/get_it.dart";
import "package:flutter_application_1/app/router/app_router.dart";
import "package:flutter_application_1/core/theme/app_theme.dart";
import "package:flutter_application_1/core/theme/theme_provider.dart";
import "package:flutter_application_1/core/l10n/app_localizations.dart";
import "package:flutter_application_1/core/l10n/locale_provider.dart";
import "package:flutter_application_1/features/auth/presentation/blocs/blocs.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:talker_flutter/talker_flutter.dart";

class CoinsApp extends StatefulWidget {
  const CoinsApp({super.key});

  @override
  State<CoinsApp> createState() => _CoinsAppState();
}

class _CoinsAppState extends State<CoinsApp> with WidgetsBindingObserver {
  final _appRouter = getIt.get<AppRouter>();
  final _localeProvider = getIt.get<LocaleProvider>();
  final _themeProvider = getIt.get<ThemeProvider>();
  final _appTheme = getIt.get<AppTheme>();

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
    _themeProvider.setResolvedTheme(
      WidgetsBinding.instance.platformDispatcher.platformBrightness,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => getIt.get<AuthBloc>()..add(AuthAppStarted()),
      child: BlocListener<AuthBloc, AuthState>(
        listenWhen: (_, current) =>
            current.status == AuthStatus.authenticated ||
            current.status == AuthStatus.unauthenticated,
        listener: (_, state) {
          switch (state.status) {
            case AuthStatus.authenticated:
              _appRouter.replaceAll([const MainLayoutRoute()]);
            case AuthStatus.unauthenticated:
              _appRouter.replaceAll([const LoginRoute()]);
            default:
              break;
          }
        },
        child: ListenableBuilder(
          listenable: Listenable.merge([_localeProvider, _themeProvider]),
          builder: (context, child) {
            final theme = _themeProvider.isDark
                ? _appTheme.darkTheme
                : _appTheme.lightTheme;

            return MaterialApp.router(
              title: "Coins App",
              locale: _localeProvider.locale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              theme: theme,
              routerConfig: _appRouter.config(
                navigatorObservers: () => [
                  TalkerRouteObserver(getIt.get<Talker>()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
