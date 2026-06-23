import "dart:async";

import "package:flutter/foundation.dart";
import "package:flutter_application_1/core/logging/talker_mobx_async_trace.dart";
import "package:flutter_application_1/core/usecase/usecase.dart";
import "package:flutter_application_1/features/crypto/domain/entities/crypto_coin.dart";
import "package:flutter_application_1/features/crypto/domain/usecases/get_coins_list.dart";
import "package:mobx/mobx.dart";
import "package:talker_flutter/talker_flutter.dart";

part "crypto_list_store.g.dart";

class CryptoListStore = AbstractCryptoListStore with _$CryptoListStore;

abstract class AbstractCryptoListStore with Store {
  final GetCoinsList _getCoinsList;
  final Talker _talker;

  @observable
  List<CryptoCoin> coins = [];

  @observable
  bool isLoading = false;

  @observable
  Object? error;

  AbstractCryptoListStore({
    required GetCoinsList getCoinsList,
    required Talker talker,
  }) : _getCoinsList = getCoinsList,
       _talker = talker;

  @action
  Future<void> loadCoins() async {
    final trace = TalkerMobxAsyncTrace.start(_talker, "loadCoins");
    try {
      runInAction(() {
        error = null;
        isLoading = coins.isEmpty;
      });

      final result = await _getCoinsList(const NoParams());
      result.fold((failure) => error = failure, (next) {
        if (listEquals(coins, next)) return;
        coins = next;
      });
    } catch (error, stackTrace) {
      this.error = error;
      _talker.handle(error, stackTrace);
    } finally {
      isLoading = false;
      trace.end();
    }
  }
}
