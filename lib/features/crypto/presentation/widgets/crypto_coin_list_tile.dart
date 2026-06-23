import "package:flutter/material.dart";

import "package:flutter_application_1/features/crypto/domain/entities/crypto_coin.dart";

class CryptoCoinListTile extends StatelessWidget {
  final CryptoCoin coin;
  final void Function(CryptoCoin coin) onCoinTap;

  const CryptoCoinListTile({
    super.key,
    required this.coin,
    required this.onCoinTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(coin.name),
      subtitle: Text("${coin.usdPrice} \$"),
      leading: Image.network(coin.fullImageUrl, width: 40, height: 40),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () => onCoinTap(coin),
    );
  }
}
