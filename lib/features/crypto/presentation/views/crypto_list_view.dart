import "package:flutter/material.dart";
import "package:flutter_application_1/features/crypto/presentation/stores/crypto_list_store.dart";
import "package:flutter_application_1/features/crypto/presentation/widgets/crypto_coin_list_tile.dart";
import "package:flutter_application_1/core/navigator/app_navigator.dart";
import "package:flutter_application_1/core/widgets/custom_error_widget/custom_error_widget.dart";
import "package:flutter_application_1/core/widgets/custom_refresh_indicator/custom_refresh_indicator.dart";
import "package:flutter_mobx/flutter_mobx.dart";

class CryptoListView extends StatefulWidget {
  final CryptoListStore cryptoListStore;
  final AppNavigator navigator;

  const CryptoListView({
    super.key,
    required this.navigator,
    required this.cryptoListStore,
  });

  @override
  State<CryptoListView> createState() => _CryptoListViewState();
}

class _CryptoListViewState extends State<CryptoListView> {
  late final CryptoListStore _cryptoListStore = widget.cryptoListStore;

  @override
  void initState() {
    super.initState();
    _cryptoListStore.loadCoins();
  }

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: _cryptoListStore.loadCoins,
      child: CustomScrollView(
        slivers: [
          CryptoListBody(
            cryptoListStore: _cryptoListStore,
            navigator: widget.navigator,
          ),
        ],
      ),
    );
  }
}

class CryptoListBody extends StatelessWidget {
  final CryptoListStore _cryptoListStore;
  final AppNavigator navigator;

  const CryptoListBody({
    super.key,
    required CryptoListStore cryptoListStore,
    required this.navigator,
  }) : _cryptoListStore = cryptoListStore;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (_cryptoListStore.isLoading) {
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (_cryptoListStore.error != null) {
          return SliverToBoxAdapter(
            child: CustomErrorWidget(
              error: _cryptoListStore.error.toString(),
              onRetry: _cryptoListStore.loadCoins,
            ),
          );
        }

        return SliverList.separated(
          itemCount: _cryptoListStore.coins.length,
          separatorBuilder: (context, index) => Divider(
            indent: 15,
            endIndent: 15,
            radius: const BorderRadius.all(Radius.circular(24)),
            color: Theme.of(context).dividerColor,
          ),
          itemBuilder: (context, index) {
            final coin = _cryptoListStore.coins[index];
            return CryptoCoinListTile(
              coin: coin,
              onCoinTap: (c) {
                navigator.openCoinDetail(c.name);
              },
            );
          },
        );
      },
    );
  }
}
