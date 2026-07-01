import "package:flutter_application_1/core/error/failures.dart";
import "package:flutter_application_1/core/utils/either.dart";
import "package:flutter_application_1/features/auth/domain/params/test_sandbox_refresh_tokens_fetch_params.dart";

abstract interface class TestSandboxRefreshTokensRepository {
  Future<Either<Failure, void>> fetch(
    TestSandboxRefreshTokensFetchParams params,
  );
}
