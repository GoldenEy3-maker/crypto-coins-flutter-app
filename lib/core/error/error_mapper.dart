import "exceptions.dart";
import "failures.dart";

Failure mapExceptionToFailure(Object error) {
  return switch (error) {
    ServerException(message: final message) => ServerFailure(message),
    CacheException(message: final message) => CacheFailure(message),
    NetworkException(message: final message) => NetworkFailure(message),
    UnknownException(message: final message) => UnknownFailure(message),
    _ => const UnknownFailure(),
  };
}
