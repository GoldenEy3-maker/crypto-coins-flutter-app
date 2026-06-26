import "package:flutter_application_1/core/error/failures.dart";
import "package:flutter_application_1/core/session/session.dart";
import "package:flutter_application_1/core/utils/either.dart";

import "../../domain/params/params.dart";

abstract interface class AuthRemoteDataSource {
  Future<Either<Failure, AuthSessionAuthenticated>> login(LoginParams params);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, AuthTokens>> refresh(String refreshToken);
}
