import "package:flutter_application_1/core/di/get_it.dart";
import "package:flutter_application_1/core/l10n/locale_provider.dart";
import "package:flutter_application_1/core/l10n/locale_storage.dart";
import "package:flutter_application_1/core/l10n/resolve_initial_locale.dart";
import "package:flutter_application_1/core/network/api_client.dart";
import "package:flutter_application_1/core/network/dio_factory.dart";
import "package:flutter_application_1/core/network/interceptors/auth_token_interceptor.dart";
import "package:flutter_application_1/core/network/interceptors/talker_interceptor.dart";
import "package:flutter_application_1/core/network/token_refresher.dart";
import "package:flutter_application_1/core/session/session_repository.dart";
import "package:flutter_application_1/core/theme/app_theme.dart";
import "package:flutter_application_1/core/theme/theme_provider.dart";
import "package:flutter_application_1/core/theme/theme_storage.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:talker_flutter/talker_flutter.dart";

void registerCoreScope() {
  final talker = getIt.get<Talker>();
  final prefs = getIt.get<SharedPreferences>();
  final localeStorage = LocaleStorage(prefs: prefs);
  final initialLocale = resolveInitialLocale(localeStorage);
  final themeStorage = ThemeStorage(prefs: prefs);

  getIt.registerLazySingleton<AppTheme>(() => AppTheme());

  getIt.registerLazySingleton<ApiClient>(() {
    final dio = const DioFactory().create();

    dio.interceptors.add(TalkerInterceptor(talker: talker));

    dio.interceptors.add(
      AuthTokenInterceptor(
        dio: dio,
        sessionRepository: getIt.get<SessionRepository>(),
        tokenRefresher: getIt.get<TokenRefresher>(),
      ),
    );

    return ApiClient(dio: dio);
  });

  getIt.registerSingleton<LocaleStorage>(localeStorage);

  getIt.registerLazySingleton<LocaleProvider>(
    () => LocaleProvider(localeStorage: localeStorage, locale: initialLocale),
  );

  getIt.registerSingleton<ThemeStorage>(themeStorage);
  getIt.registerLazySingleton<ThemeProvider>(
    () => ThemeProvider(themeStorage: themeStorage),
  );
}
