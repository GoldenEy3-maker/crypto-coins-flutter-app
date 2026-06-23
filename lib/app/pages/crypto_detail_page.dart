import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_application_1/core/di/get_it.dart";
import "package:flutter_application_1/features/crypto/presentation/stores/crypto_detail_store.dart";
import "package:flutter_application_1/features/crypto/presentation/views/crypto_detail_view.dart";
import "package:flutter_application_1/core/navigator/app_navigator.dart";

@RoutePage()
class CryptoDetailPage extends StatelessWidget {
  final String coinName;

  const CryptoDetailPage({super.key, required this.coinName});

  @override
  Widget build(BuildContext context) {
    final AppNavigator navigator = getIt.get<AppNavigator>();

    return CryptoDetailView(
      coinName: coinName,
      cryptoDetailStore: getIt.get<CryptoDetailStore>(),
      navigator: navigator,
    );
  }
}
