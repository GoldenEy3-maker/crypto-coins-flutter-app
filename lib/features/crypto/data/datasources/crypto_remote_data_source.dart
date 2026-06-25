import "package:dio/dio.dart";
import "package:flutter_application_1/core/config/env.dart";
import "package:flutter_application_1/core/error/failures.dart";
import "package:flutter_application_1/core/network/api_client.dart";
import "package:flutter_application_1/core/network/dio_failure_mapper.dart";
import "package:flutter_application_1/core/utils/either.dart";
import "package:flutter_application_1/features/crypto/data/models/crypto_coin_detail_model.dart";
import "package:flutter_application_1/features/crypto/data/models/crypto_coin_model.dart";

abstract class CryptoRemoteDataSource {
  Future<Either<Failure, List<CryptoCoinModel>>> getCoinsList();
  Future<Either<Failure, CryptoCoinDetailModel>> getCoinDetailByName(
    String coinName,
  );
}

class CryptoRemoteDataSourceImpl implements CryptoRemoteDataSource {
  CryptoRemoteDataSourceImpl({required this.apiClient});

  final ApiClient apiClient;

  @override
  Future<Either<Failure, List<CryptoCoinModel>>> getCoinsList() async {
    try {
      final response = await apiClient.client.get(
        "${Env.cryptoCompareBaseUrl}/data/pricemultifull?fsyms=BTC,ETH,BNB,SOL,AID,CAG,DOV&tsyms=USD",
      );
      final data = response.data as Map<String, dynamic>;
      final coins = data["RAW"] as Map<String, dynamic>;
      return Right(
        coins.entries.map((entry) {
          final usd = entry.value["USD"] as Map<String, dynamic>;
          return CryptoCoinModel.fromJson({...usd, "name": entry.key});
        }).toList(),
      );
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (e) {
      return Left(ServerFailure("Invalid coins response: $e"));
    }
  }

  @override
  Future<Either<Failure, CryptoCoinDetailModel>> getCoinDetailByName(
    String coinName,
  ) async {
    try {
      final response = await apiClient.client.get(
        "${Env.cryptoCompareBaseUrl}/data/pricemultifull?fsyms=$coinName&tsyms=USD",
      );
      final data = response.data as Map<String, dynamic>;
      final coin = data["RAW"][coinName]["USD"] as Map<String, dynamic>;
      return Right(CryptoCoinDetailModel.fromJson({...coin, "name": coinName}));
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (e) {
      return Left(ServerFailure("Invalid coin detail response: $e"));
    }
  }
}
