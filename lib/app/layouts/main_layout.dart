import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_application_1/core/l10n/app_localizations.dart";

import "package:flutter_application_1/app/router/app_router.dart";
import "main_layout_app_bar_config.dart";

@RoutePage()
class MainLayoutPage extends StatelessWidget {
  const MainLayoutPage({super.key});

  bool _isCoinsShellRoute(int index) => index == 1;

  bool _isCoinDetailRoute(StackRouter? router) =>
      router?.current.name == CryptoDetailRoute.name;

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [HomeRoute(), CoinsShellRoute(), SettingsRoute()],
      transitionBuilder: (context, child, animation) =>
          FadeTransition(opacity: animation, child: child),
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        final coinsRouter = context.innerRouterOf<StackRouter>(
          CoinsShellRoute.name,
        );
        final isCoinsTabActive = _isCoinsShellRoute(tabsRouter.activeIndex);
        final appBarConfig = MainLayoutAppBarResolver.resolve(
          context: context,
          coinsRouter: coinsRouter,
          isCoinsTabActive: isCoinsTabActive,
          activeTabIndexRouter: tabsRouter.activeIndex,
        );

        return Scaffold(
          appBar: AppBar(
            leading: appBarConfig.showBackButton
                ? IconButton(
                    onPressed: () => coinsRouter?.maybePop(),
                    icon: const Icon(Icons.arrow_back),
                  )
                : null,
            title: Text(appBarConfig.title),
          ),
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: (index) {
              if (_isCoinsShellRoute(index) &&
                  isCoinsTabActive &&
                  _isCoinDetailRoute(coinsRouter)) {
                coinsRouter?.navigate(const CryptoListRoute());
                return;
              }
              tabsRouter.setActiveIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                label: AppLocalizations.of(context)!.bottomNavigationBarHome,
                icon: const Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: AppLocalizations.of(context)!.bottomNavigationBarCoins,
                icon: const Icon(Icons.currency_bitcoin),
              ),
              BottomNavigationBarItem(
                label: AppLocalizations.of(
                  context,
                )!.bottomNavigationBarSettings,
                icon: const Icon(Icons.settings),
              ),
            ],
          ),
        );
      },
    );
  }
}
