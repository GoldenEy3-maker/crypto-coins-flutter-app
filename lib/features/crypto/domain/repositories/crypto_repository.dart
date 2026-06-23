import "package:flutter_application_1/core/error/failures.dart";
import "package:flutter_application_1/core/utils/either.dart";
import "package:flutter_application_1/features/crypto/domain/entities/crypto_coin.dart";
import "package:flutter_application_1/features/crypto/domain/entities/crypto_coin_detail.dart";

abstract class CryptoRepository {
  Future<Either<Failure, List<CryptoCoin>>> getCoinsList();
  Future<Either<Failure, CryptoCoinDetail>> getCoinDetailByName(
    String coinName,
  );
}
