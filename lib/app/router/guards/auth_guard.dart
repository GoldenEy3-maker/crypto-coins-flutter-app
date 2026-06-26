import "dart:async";

import "package:auto_route/auto_route.dart";
import "package:flutter_application_1/app/router/app_router.dart";
import "package:flutter_application_1/core/di/get_it.dart";
import "package:flutter_application_1/core/session/session.dart";

class AuthGuard extends AutoRouteGuard {
  @override
  FutureOr<void> onNavigation(NavigationResolver resolver, StackRouter router) {
    final session = getIt<SessionRepository>().currentSession;

    if (session is AuthSessionAuthenticated) {
      resolver.next();
    } else {
      resolver.redirectUntil(const LoginRoute());
    }
  }
}
