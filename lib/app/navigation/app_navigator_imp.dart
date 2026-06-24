import "package:flutter_application_1/core/navigator/app_navigator.dart";

import "../router/app_router.dart";

class AppNavigatorImpl implements AppNavigator {
  final AppRouter _router;

  AppNavigatorImpl(this._router);

  @override
  void openHome() {
    _router.navigate(const HomeRoute());
  }

  @override
  void openSettings() {
    _router.navigate(const SettingsRoute());
  }

  @override
  void openCoinsList() {
    _router.navigate(const CoinsShellRoute());
  }

  @override
  void openCoinDetail(String coinName) {
    _router.navigate(CryptoDetailRoute(coinName: coinName));
  }

  @override
  void openBlockTimerExample() {
    _router.navigate(const TimerRoute());
  }

  @override
  void back() {
    _router.maybePop();
  }
}
