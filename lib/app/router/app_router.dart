import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_application_1/app/router/modal_sheet_builder.dart";
import "package:flutter_application_1/app/pages/coins_shell_page.dart";
import "package:flutter_application_1/app/pages/crypto_detail_page.dart";
import "package:flutter_application_1/app/pages/crypto_list_page.dart";
import "package:flutter_application_1/app/pages/settings_page.dart";
import "package:flutter_application_1/app/pages/home_page.dart";
import "package:flutter_application_1/app/pages/timer_page.dart";
import "package:flutter_application_1/app/pages/home_shell_page.dart";
import "package:flutter_application_1/app/layouts/main_layout.dart";

part "app_router.gr.dart";

@AutoRouterConfig(replaceInRouteName: "Page,Route")
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: MainLayoutRoute.page,
      path: "/",
      children: [
        AutoRoute(
          page: HomeShellRoute.page,
          children: [
            AutoRoute(page: HomeRoute.page, initial: true),
            AutoRoute(page: TimerRoute.page),
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
