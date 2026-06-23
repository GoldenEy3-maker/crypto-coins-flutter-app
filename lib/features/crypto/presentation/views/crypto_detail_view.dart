import "package:flutter/material.dart";
import "package:flutter_application_1/features/crypto/presentation/stores/crypto_detail_store.dart";
import "package:flutter_application_1/core/navigator/app_navigator.dart";
import "package:flutter_application_1/core/widgets/custom_error_widget/custom_error_widget.dart";
import "package:flutter_application_1/core/widgets/custom_refresh_indicator/custom_refresh_indicator.dart";
import "package:flutter_mobx/flutter_mobx.dart";

class CryptoDetailView extends StatefulWidget {
  final String coinName;
  final CryptoDetailStore cryptoDetailStore;
  final AppNavigator navigator;

  const CryptoDetailView({
    super.key,
    required this.coinName,
    required this.cryptoDetailStore,
    required this.navigator,
  });

  @override
  State<CryptoDetailView> createState() => _CryptoDetailViewState();
}

class _CryptoDetailViewState extends State<CryptoDetailView> {
  late final CryptoDetailStore _cryptoDetailStore = widget.cryptoDetailStore;

  @override
  void initState() {
    super.initState();
    _cryptoDetailStore.loadCoinDetailByName(widget.coinName);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: widget.navigator.back,
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          body: CustomRefreshIndicator(
            onRefresh: () =>
                _cryptoDetailStore.refreshCoinDetailByName(widget.coinName),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              clipBehavior: Clip.none,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: CryptoDetailBody(
                    coinName: widget.coinName,
                    cryptoDetailStore: _cryptoDetailStore,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CryptoDetailBody extends StatelessWidget {
  final CryptoDetailStore _cryptoDetailStore;
  final String coinName;

  const CryptoDetailBody({
    super.key,
    required this.coinName,
    required CryptoDetailStore cryptoDetailStore,
  }) : _cryptoDetailStore = cryptoDetailStore;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (_cryptoDetailStore.isLoading) {
          return const SizedBox(
            height: double.infinity,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (_cryptoDetailStore.error != null) {
          return CustomErrorWidget(
            error: _cryptoDetailStore.error.toString(),
            onRetry: () => _cryptoDetailStore.loadCoinDetailByName(coinName),
          );
        }

        return Column(
          children: [
            const SizedBox(height: 16),
            Center(
              child: Image.network(
                _cryptoDetailStore.coin?.fullImageUrl ?? "",
                width: 120,
                height: 120,
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                _cryptoDetailStore.coin?.name ?? "",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: Card(
                  color: Colors.amber,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Text(
                      "${_cryptoDetailStore.coin?.usdPrice} \$",
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SizedBox(
                width: double.infinity,
                child: Card(
                  color: Colors.amber,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Hight 24 Hours",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "${_cryptoDetailStore.coin?.high24h} \$",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Low 24 Hours",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "${_cryptoDetailStore.coin?.low24h} \$",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Last Update",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "${_cryptoDetailStore.coin?.lastUpdate.toString()}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
