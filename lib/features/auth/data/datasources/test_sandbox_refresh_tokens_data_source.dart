import "package:dio/dio.dart";
import "package:flutter_application_1/core/error/error_mapper.dart";
import "package:flutter_application_1/core/error/failures.dart";
import "package:flutter_application_1/core/network/api_client.dart";
import "package:flutter_application_1/core/utils/either.dart";
import "package:flutter_application_1/features/auth/domain/params/params.dart";

abstract interface class TestSandboxRefreshTokensDataSource {
  Future<Either<Failure, void>> fetch(
    TestSandboxRefreshTokensFetchParams params,
  );
}

class TestSandboxRefreshTokensDataSourceImpl
    implements TestSandboxRefreshTokensDataSource {
  final ApiClient _apiClient;

  TestSandboxRefreshTokensDataSourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<Either<Failure, void>> fetch(
    TestSandboxRefreshTokensFetchParams params,
  ) async {
    try {
      final response = await _apiClient.client.get(
        "https://httpbun.com/mix/s=${params.emulateFailure ? 401 : 200}/d=${params.delay.inSeconds}",
      );
      return Right(null);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
