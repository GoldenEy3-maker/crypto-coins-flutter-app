import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_application_1/core/di/get_it.dart";
import "package:flutter_application_1/core/l10n/app_localizations.dart";
import "package:flutter_application_1/core/navigator/app_navigator.dart";
import "package:flutter_application_1/features/home/presentation/views/home_view.dart";

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final i10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(i10n.bottomNavigationBarHome)),
      body: HomeView(navigator: getIt.get<AppNavigator>()),
    );
  }
}
