import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_application_1/core/di/get_it.dart";
import "package:flutter_application_1/core/navigator/app_navigator.dart";
import "package:flutter_application_1/features/crypto/presentation/stores/crypto_detail_store.dart";
import "package:flutter_application_1/features/crypto/presentation/views/crypto_detail_view.dart";

@RoutePage()
class CryptoDetailPage extends StatefulWidget {
  final String coinName;

  const CryptoDetailPage({super.key, required this.coinName});

  @override
  State<CryptoDetailPage> createState() => _CryptoDetailPageState();
}

class _CryptoDetailPageState extends State<CryptoDetailPage> {
  late final CryptoDetailStore _cryptoDetailStore = getIt<CryptoDetailStore>();
  late final AppNavigator _navigator = getIt<AppNavigator>();

  @override
  Widget build(BuildContext context) {
    return CryptoDetailView(
      coinName: widget.coinName,
      cryptoDetailStore: _cryptoDetailStore,
      navigator: _navigator,
    );
  }
}
