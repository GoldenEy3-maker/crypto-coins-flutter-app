// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [CoinsShellPage]
class CoinsShellRoute extends PageRouteInfo<void> {
  const CoinsShellRoute({List<PageRouteInfo>? children})
    : super(CoinsShellRoute.name, initialChildren: children);

  static const String name = 'CoinsShellRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CoinsShellPage();
    },
  );
}

/// generated route for
/// [CryptoDetailPage]
class CryptoDetailRoute extends PageRouteInfo<CryptoDetailRouteArgs> {
  CryptoDetailRoute({
    Key? key,
    required String coinName,
    List<PageRouteInfo>? children,
  }) : super(
         CryptoDetailRoute.name,
         args: CryptoDetailRouteArgs(key: key, coinName: coinName),
         initialChildren: children,
       );

  static const String name = 'CryptoDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CryptoDetailRouteArgs>();
      return CryptoDetailPage(key: args.key, coinName: args.coinName);
    },
  );
}

class CryptoDetailRouteArgs {
  const CryptoDetailRouteArgs({this.key, required this.coinName});

  final Key? key;

  final String coinName;

  @override
  String toString() {
    return 'CryptoDetailRouteArgs{key: $key, coinName: $coinName}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CryptoDetailRouteArgs) return false;
    return key == other.key && coinName == other.coinName;
  }

  @override
  int get hashCode => key.hashCode ^ coinName.hashCode;
}

/// generated route for
/// [CryptoListPage]
class CryptoListRoute extends PageRouteInfo<void> {
  const CryptoListRoute({List<PageRouteInfo>? children})
    : super(CryptoListRoute.name, initialChildren: children);

  static const String name = 'CryptoListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CryptoListPage();
    },
  );
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomePage();
    },
  );
}

/// generated route for
/// [HomeShellPage]
class HomeShellRoute extends PageRouteInfo<void> {
  const HomeShellRoute({List<PageRouteInfo>? children})
    : super(HomeShellRoute.name, initialChildren: children);

  static const String name = 'HomeShellRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeShellPage();
    },
  );
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginPage();
    },
  );
}

/// generated route for
/// [MainLayoutPage]
class MainLayoutRoute extends PageRouteInfo<void> {
  const MainLayoutRoute({List<PageRouteInfo>? children})
    : super(MainLayoutRoute.name, initialChildren: children);

  static const String name = 'MainLayoutRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainLayoutPage();
    },
  );
}

/// generated route for
/// [PostsPage]
class PostsRoute extends PageRouteInfo<void> {
  const PostsRoute({List<PageRouteInfo>? children})
    : super(PostsRoute.name, initialChildren: children);

  static const String name = 'PostsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PostsPage();
    },
  );
}

/// generated route for
/// [SettingsPage]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsPage();
    },
  );
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashPage();
    },
  );
}

/// generated route for
/// [TimerPage]
class TimerRoute extends PageRouteInfo<void> {
  const TimerRoute({List<PageRouteInfo>? children})
    : super(TimerRoute.name, initialChildren: children);

  static const String name = 'TimerRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TimerPage();
    },
  );
}
