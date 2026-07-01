import "package:flutter/foundation.dart";
import "package:flutter_application_1/core/di/get_it.dart";
import "package:flutter_application_1/core/network/token_refresher.dart";
import "package:flutter_application_1/core/session/session_repository.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../data/datasources/datasources.dart";
import "../data/repositories/repositories.dart";
import "../domain/repositories/repositories.dart";
import "../domain/usecases/usecases.dart";
import "../presentation/blocs/blocs.dart";

void registerAuthModule() {
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => MockAuthRemoteDataSource(),
  );

  getIt.registerLazySingleton<AuthLocalDataSource>(() {
    if (kDebugMode) {
      final sharedPreferences = getIt.get<SharedPreferences>();
      return AuthLocalSharedPreferencesDataSource(
        sharedPreferences: sharedPreferences,
      );
    } else {
      final secureStorage = getIt.get<FlutterSecureStorage>();
      return AuthLocalSecureStorageDataSource(secureStorage: secureStorage);
    }
  });

  getIt.registerLazySingleton<AuthSessionRepository>(
    () => AuthSessionRepository(),
  );
  getIt.registerLazySingleton<SessionRepository>(
    () => getIt<AuthSessionRepository>(),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: getIt.get<AuthRemoteDataSource>(),
      localDataSource: getIt.get<AuthLocalDataSource>(),
      sessionRepository: getIt.get<AuthSessionRepository>(),
    ),
  );

  getIt.registerLazySingleton<TokenRefresher>(
    () => getIt.get<AuthRepository>(),
  );

  getIt.registerLazySingleton<Login>(
    () => Login(authRepository: getIt.get<AuthRepository>()),
  );

  getIt.registerLazySingleton<RestoreSession>(
    () => RestoreSession(authRepository: getIt.get<AuthRepository>()),
  );

  getIt.registerLazySingleton<Logout>(
    () => Logout(authRepository: getIt.get<AuthRepository>()),
  );

  getIt.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      login: getIt.get<Login>(),
      restoreSession: getIt.get<RestoreSession>(),
      logout: getIt.get<Logout>(),
    ),
  );
}
