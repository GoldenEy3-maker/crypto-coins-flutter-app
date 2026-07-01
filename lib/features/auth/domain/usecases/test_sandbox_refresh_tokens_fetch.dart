import "package:flutter_application_1/core/error/failures.dart";
import "package:flutter_application_1/core/usecase/usecase.dart";
import "package:flutter_application_1/core/utils/either.dart";
import "package:flutter_application_1/features/auth/domain/params/params.dart";
import "package:flutter_application_1/features/auth/domain/repositories/repositories.dart";

class TestSandboxRefreshTokensFetch
    implements UseCase<void, TestSandboxRefreshTokensFetchParams> {
  final TestSandboxRefreshTokensRepository _repository;

  TestSandboxRefreshTokensFetch({
    required TestSandboxRefreshTokensRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Failure, void>> call(
    TestSandboxRefreshTokensFetchParams params,
  ) {
    return _repository.fetch(params);
  }
}
