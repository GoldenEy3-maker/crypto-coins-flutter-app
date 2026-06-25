import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_application_1/core/di/get_it.dart";
import "package:flutter_application_1/core/l10n/app_localizations.dart";
import "package:flutter_application_1/core/navigator/app_navigator.dart";
import "package:flutter_application_1/features/crypto/presentation/stores/crypto_list_store.dart";
import "package:flutter_application_1/features/crypto/presentation/views/crypto_list_view.dart";

@RoutePage()
class CryptoListPage extends StatefulWidget {
  const CryptoListPage({super.key});

  @override
  State<CryptoListPage> createState() => _CryptoListPageState();
}

class _CryptoListPageState extends State<CryptoListPage> {
  late final CryptoListStore _cryptoListStore = getIt<CryptoListStore>();
  late final AppNavigator _navigator = getIt<AppNavigator>();

  @override
  Widget build(BuildContext context) {
    final i10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(i10n.appTitle)),
      body: CryptoListView(
        navigator: _navigator,
        cryptoListStore: _cryptoListStore,
      ),
    );
  }
}
