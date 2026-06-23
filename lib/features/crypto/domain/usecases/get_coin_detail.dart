import "package:flutter_application_1/core/error/failures.dart";
import "package:flutter_application_1/core/usecase/usecase.dart";
import "package:flutter_application_1/core/utils/either.dart";
import "package:flutter_application_1/features/crypto/domain/entities/crypto_coin_detail.dart";
import "package:flutter_application_1/features/crypto/domain/repositories/crypto_repository.dart";

class GetCoinDetail implements UseCase<CryptoCoinDetail, String> {
  const GetCoinDetail(this._repository);

  final CryptoRepository _repository;

  @override
  Future<Either<Failure, CryptoCoinDetail>> call(String coinName) =>
      _repository.getCoinDetailByName(coinName);
}
