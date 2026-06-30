import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_application_1/core/l10n/app_localizations.dart";

import "package:flutter_application_1/app/router/app_router.dart";

@RoutePage()
class MainLayoutPage extends StatelessWidget {
  const MainLayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final i10n = AppLocalizations.of(context)!;

    return AutoTabsScaffold(
      routes: [const HomeRoute(), const CoinsShellRoute(), SettingsRoute()],
      transitionBuilder: (context, child, animation) =>
          FadeTransition(opacity: animation, child: child),
      bottomNavigationBuilder: (context, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: i10n.bottomNavigationBarHome,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.currency_bitcoin),
              label: i10n.bottomNavigationBarCoins,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: i10n.bottomNavigationBarSettings,
            ),
          ],
        );
      },
    );
  }
}
