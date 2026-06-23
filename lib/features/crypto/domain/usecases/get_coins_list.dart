import "package:flutter_application_1/core/error/failures.dart";
import "package:flutter_application_1/core/usecase/usecase.dart";
import "package:flutter_application_1/core/utils/either.dart";
import "package:flutter_application_1/features/crypto/domain/entities/crypto_coin.dart";
import "package:flutter_application_1/features/crypto/domain/repositories/crypto_repository.dart";

class GetCoinsList implements UseCase<List<CryptoCoin>, NoParams> {
  const GetCoinsList(this._repository);

  final CryptoRepository _repository;

  @override
  Future<Either<Failure, List<CryptoCoin>>> call(_) =>
      _repository.getCoinsList();
}
