import "package:flutter_application_1/core/error/failures.dart";
import "package:flutter_application_1/core/utils/either.dart";
import "package:flutter_application_1/features/crypto/data/models/crypto_coin_detail_model.dart";
import "package:flutter_application_1/features/crypto/data/models/crypto_coin_model.dart";
import "package:hive/hive.dart";

abstract class CryptoLocalDataSource {
  Future<void> saveCoinsList(List<CryptoCoinModel> coins);
  Future<void> saveCoinDetail(CryptoCoinDetailModel coinDetail);
  Future<Either<Failure, List<CryptoCoinModel>>> getCoinsList();
  Future<Either<Failure, CryptoCoinDetailModel>> getCoinDetailByName(
    String coinName,
  );
}

class CryptoLocalDataSourceImpl implements CryptoLocalDataSource {
  final _cryptoCoinsBoxKey = "crypto_coins";
  final _cryptoCoinDetailsBoxKey = "crypto_coin_details";

  Future<Box<dynamic>> _openBox(String name) async {
    if (Hive.isBoxOpen(name)) return Hive.box<dynamic>(name);
    return Hive.openBox<dynamic>(name);
  }

  @override
  Future<void> saveCoinsList(List<CryptoCoinModel> coins) async {
    final box = await _openBox(_cryptoCoinsBoxKey);
    final raw = coins.map((coin) => coin.toJson()).toList();
    await box.put(_cryptoCoinsBoxKey, raw);
  }

  @override
  Future<void> saveCoinDetail(CryptoCoinDetailModel coinDetail) async {
    final box = await _openBox(_cryptoCoinDetailsBoxKey);
    await box.put(coinDetail.name, coinDetail.toJson());
  }

  @override
  Future<Either<Failure, List<CryptoCoinModel>>> getCoinsList() async {
    try {
      final box = await _openBox(_cryptoCoinsBoxKey);
      final rawList =
          (box.get(_cryptoCoinsBoxKey, defaultValue: <dynamic>[]) as List)
              .cast<dynamic>();

      final coins = rawList
          .map(
            (rawCoin) =>
                CryptoCoinModel.fromJson(Map<String, dynamic>.from(rawCoin)),
          )
          .toList();
      return Right(coins);
    } catch (error) {
      return Left(CacheFailure("Failed to read cached coins: $error"));
    }
  }

  @override
  Future<Either<Failure, CryptoCoinDetailModel>> getCoinDetailByName(
    String coinName,
  ) async {
    try {
      final box = await _openBox(_cryptoCoinDetailsBoxKey);
      final rawCoin = box.get(coinName);
      if (rawCoin == null) {
        return Left(CacheFailure("No cached coin detail for $coinName"));
      }

      final coinDetail = CryptoCoinDetailModel.fromJson(
        Map<String, dynamic>.from(rawCoin as Map),
      );
      return Right(coinDetail);
    } catch (error) {
      return Left(CacheFailure("Failed to read cached coin detail: $error"));
    }
  }
}
