import "package:flutter_application_1/core/error/failures.dart";
import "package:flutter_application_1/core/session/session.dart";
import "package:flutter_application_1/core/usecase/usecase.dart";
import "package:flutter_application_1/core/utils/either.dart";

import "../repositories/repositories.dart";

class RefreshTokens implements UseCase<AuthSession, NoParams> {
  final AuthRepository _authRepository;

  RefreshTokens({required AuthRepository authRepository})
    : _authRepository = authRepository;

  @override
  Future<Either<Failure, AuthSession>> call(NoParams params) {
    return _authRepository.refreshTokens();
  }
}
