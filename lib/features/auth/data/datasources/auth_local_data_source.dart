import "package:flutter_application_1/core/error/failures.dart";
import "package:flutter_application_1/core/session/session.dart";
import "package:flutter_application_1/core/utils/either.dart";

abstract interface class AuthLocalDataSource {
  Future<Either<Failure, AuthSessionAuthenticated>> readSession();
  Future<Either<Failure, void>> saveSession(AuthSessionAuthenticated session);
  Future<Either<Failure, void>> clearSession();
}
