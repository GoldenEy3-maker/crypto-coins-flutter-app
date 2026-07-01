import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_application_1/app/router/guards/auth_guard.dart";
import "package:flutter_application_1/app/router/guards/guest_guard.dart";
import "package:flutter_application_1/app/router/modal_sheet_builder.dart";
import "package:flutter_application_1/app/router/pages/coins_shell_page.dart";
import "package:flutter_application_1/app/router/pages/crypto_detail_page.dart";
import "package:flutter_application_1/app/router/pages/crypto_list_page.dart";
import "package:flutter_application_1/app/router/pages/settings_page.dart";
import "package:flutter_application_1/app/router/pages/home_page.dart";
import "package:flutter_application_1/app/router/pages/timer_page.dart";
import "package:flutter_application_1/app/router/pages/home_shell_page.dart";
import "package:flutter_application_1/app/router/pages/posts_page.dart";
import "package:flutter_application_1/app/layouts/main_layout.dart";
import "package:flutter_application_1/app/router/pages/login_page.dart";
import "package:flutter_application_1/app/router/pages/splash_page.dart";
import "package:flutter_application_1/app/router/pages/test_sandbox_refresh_tokens_page.dart";

part "app_router.gr.dart";

@AutoRouterConfig(replaceInRouteName: "Page,Route")
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: LoginRoute.page, guards: [GuestGuard()]),
    AutoRoute(
      page: MainLayoutRoute.page,
      path: "/",
      guards: [AuthGuard()],
      children: [
        AutoRoute(
          page: HomeShellRoute.page,
          children: [
            AutoRoute(page: HomeRoute.page, initial: true),
            AutoRoute(page: TimerRoute.page),
            AutoRoute(page: PostsRoute.page),
            AutoRoute(page: TestSandboxRefreshTokensRoute.page),
          ],
        ),
        AutoRoute(
          page: CoinsShellRoute.page,
          children: [AutoRoute(page: CryptoListRoute.page, initial: true)],
        ),
        AutoRoute(page: SettingsRoute.page),
      ],
    ),
    CustomRoute(
      page: CryptoDetailRoute.page,
      customRouteBuilder: modalSheetBuilder,
    ),
  ];

  @override
  List<AutoRouteGuard> get guards => [];
}
