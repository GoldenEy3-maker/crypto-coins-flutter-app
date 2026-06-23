import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_application_1/core/l10n/app_localizations.dart";

import "package:flutter_application_1/app/router/app_router.dart";

class MainLayoutAppBarConfig {
  final String title;
  final bool showBackButton;

  const MainLayoutAppBarConfig({
    required this.title,
    this.showBackButton = false,
  });
}

class MainLayoutAppBarResolver {
  static MainLayoutAppBarConfig resolve({
    required BuildContext context,
    required StackRouter? coinsRouter,
    required bool isCoinsTabActive,
    required int activeTabIndexRouter,
  }) {
    final isDetailRoute = coinsRouter?.current.name == CryptoDetailRoute.name;

    if (isCoinsTabActive && isDetailRoute) {
      return const MainLayoutAppBarConfig(title: "", showBackButton: true);
    }

    if (activeTabIndexRouter == 0) {
      return MainLayoutAppBarConfig(
        title: AppLocalizations.of(context)!.bottomNavigationBarHome,
      );
    }

    if (activeTabIndexRouter == 2) {
      return MainLayoutAppBarConfig(
        title: AppLocalizations.of(context)!.bottomNavigationBarSettings,
      );
    }

    return MainLayoutAppBarConfig(
      title: AppLocalizations.of(context)!.appTitle,
    );
  }
}
