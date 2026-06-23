sealed class Failure {
  const Failure(this.message);

  final String message;

  @override
  String toString() => message;
}

final class ServerFailure extends Failure {
  const ServerFailure([super.message = "Server failure"]);
}

final class CacheFailure extends Failure {
  const CacheFailure([super.message = "Cache failure"]);
}

final class NetworkFailure extends Failure {
  const NetworkFailure([super.message = "Network failure"]);
}

final class UnknownFailure extends Failure {
  const UnknownFailure([super.message = "Unknown failure"]);
}
