import "package:flutter_application_1/core/error/failures.dart";
import "package:flutter_application_1/core/utils/either.dart";
import "package:flutter_application_1/features/auth/data/datasources/datasources.dart";
import "package:flutter_application_1/features/auth/domain/params/params.dart";
import "package:flutter_application_1/features/auth/domain/repositories/repositories.dart";

class TestSandboxRefreshTokensRepositoryImpl
    implements TestSandboxRefreshTokensRepository {
  final TestSandboxRefreshTokensDataSource _dataSource;

  TestSandboxRefreshTokensRepositoryImpl({
    required TestSandboxRefreshTokensDataSource dataSource,
  }) : _dataSource = dataSource;

  @override
  Future<Either<Failure, void>> fetch(
    TestSandboxRefreshTokensFetchParams params,
  ) {
    return _dataSource.fetch(params);
  }
}
