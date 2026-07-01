import "package:flutter_application_1/core/error/failures.dart";
import "package:flutter_application_1/core/session/session.dart";
import "package:flutter_application_1/core/utils/either.dart";

abstract interface class TokenRefresher {
  Future<Either<Failure, AuthSession>> refreshTokens();
}
