import "package:flutter_application_1/core/error/error_mapper.dart";
import "package:flutter_application_1/core/error/failures.dart";
import "package:flutter_application_1/core/utils/either.dart";
import "package:flutter_application_1/features/crypto/data/datasources/crypto_local_data_source.dart";
import "package:flutter_application_1/features/crypto/data/datasources/crypto_remote_data_source.dart";
import "package:flutter_application_1/features/crypto/domain/entities/crypto_coin.dart";
import "package:flutter_application_1/features/crypto/domain/entities/crypto_coin_detail.dart";
import "package:flutter_application_1/features/crypto/domain/repositories/crypto_repository.dart";

class CryptoRepositoryImpl implements CryptoRepository {
  final CryptoRemoteDataSource _remoteDataSource;
  final CryptoLocalDataSource _localDataSource;

  const CryptoRepositoryImpl({
    required CryptoRemoteDataSource remoteDataSource,
    required CryptoLocalDataSource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  @override
  Future<Either<Failure, List<CryptoCoin>>> getCoinsList() async {
    try {
      final remoteResult = await _remoteDataSource.getCoinsList();
      return remoteResult.fold(
        (_) async {
          final cachedResult = await _localDataSource.getCoinsList();
          return cachedResult.map(
            (coins) => coins.map((coin) => coin.toEntity()).toList(),
          );
        },
        (coins) async {
          await _localDataSource.saveCoinsList(coins);
          return Right(coins.map((coin) => coin.toEntity()).toList());
        },
      );
    } catch (error) {
      return Left(mapExceptionToFailure(error));
    }
  }

  @override
  Future<Either<Failure, CryptoCoinDetail>> getCoinDetailByName(
    String coinName,
  ) async {
    try {
      final remoteResult = await _remoteDataSource.getCoinDetailByName(
        coinName,
      );
      return remoteResult.fold(
        (_) async {
          final cachedResult = await _localDataSource.getCoinDetailByName(
            coinName,
          );
          return cachedResult.map((detail) => detail.toEntity());
        },
        (detail) async {
          await _localDataSource.saveCoinDetail(detail);
          return Right(detail.toEntity());
        },
      );
    } catch (error) {
      return Left(mapExceptionToFailure(error));
    }
  }
}
