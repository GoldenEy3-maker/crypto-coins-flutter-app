import "package:flutter_application_1/core/error/failures.dart";
import "package:flutter_application_1/core/session/session.dart";
import "package:flutter_application_1/core/usecase/usecase.dart";
import "package:flutter_application_1/core/utils/either.dart";

import "../params/params.dart";
import "../repositories/repositories.dart";

class Login implements UseCase<AuthSessionAuthenticated, LoginParams> {
  final AuthRepository _authRepository;

  Login({required AuthRepository authRepository})
    : _authRepository = authRepository;

  @override
  Future<Either<Failure, AuthSessionAuthenticated>> call(LoginParams params) {
    return _authRepository.login(params);
  }
}
