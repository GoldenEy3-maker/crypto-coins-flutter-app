import "package:flutter_application_1/core/logging/talker_mobx_async_trace.dart";
import "package:flutter_application_1/features/crypto/domain/entities/crypto_coin_detail.dart";
import "package:flutter_application_1/features/crypto/domain/usecases/get_coin_detail.dart";
import "package:mobx/mobx.dart";
import "package:talker_flutter/talker_flutter.dart";

part "crypto_detail_store.g.dart";

class CryptoDetailStore = AbstractCryptoDetailStore with _$CryptoDetailStore;

abstract class AbstractCryptoDetailStore with Store {
  final GetCoinDetail _getCoinDetail;
  final Talker _talker;

  @observable
  CryptoCoinDetail? coin;

  @observable
  bool isLoading = false;

  @observable
  Object? error;

  AbstractCryptoDetailStore({
    required GetCoinDetail getCoinDetail,
    required Talker talker,
  }) : _getCoinDetail = getCoinDetail,
       _talker = talker;

  @action
  Future<void> loadCoinDetailByName(String coinName) async {
    final trace = TalkerMobxAsyncTrace.start(_talker, "loadCoinDetailByName");
    try {
      runInAction(() {
        error = null;
        isLoading = true;
      });

      final result = await _getCoinDetail(coinName);
      result.fold((failure) => error = failure, (value) => coin = value);
    } catch (error, stackTrace) {
      this.error = error;
      _talker.handle(error, stackTrace);
    } finally {
      isLoading = false;
      trace.end();
    }
  }

  @action
  Future<void> refreshCoinDetailByName(String coinName) async {
    final trace = TalkerMobxAsyncTrace.start(
      _talker,
      "refreshCoinDetailByName",
    );
    try {
      error = null;
      final result = await _getCoinDetail(coinName);
      result.fold((failure) => error = failure, (next) {
        if (coin == next) return;
        coin = next;
      });
    } catch (error, stackTrace) {
      this.error = error;
      _talker.handle(error, stackTrace);
    } finally {
      trace.end();
    }
  }
}
