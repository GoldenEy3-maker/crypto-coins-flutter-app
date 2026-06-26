import "package:flutter_application_1/core/error/failures.dart";
import "package:flutter_application_1/core/usecase/usecase.dart";
import "package:flutter_application_1/core/utils/either.dart";

import "../repositories/repositories.dart";

class Logout implements UseCase<void, NoParams> {
  final AuthRepository _authRepository;

  Logout({required AuthRepository authRepository})
    : _authRepository = authRepository;

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return _authRepository.logout();
  }
}
