import "package:flutter_application_1/core/di/get_it.dart";
import "package:flutter_application_1/app/navigation/app_navigator_imp.dart";
import "package:flutter_application_1/app/router/app_router.dart";
import "package:flutter_application_1/core/navigator/app_navigator.dart";

void registerAppScope() {
  getIt.registerSingleton<AppRouter>(AppRouter());
  getIt.registerLazySingleton<AppNavigator>(
    () => AppNavigatorImpl(getIt.get<AppRouter>()),
  );
}
