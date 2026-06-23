class ServerException implements Exception {
  const ServerException([this.message = "Server exception"]);

  final String message;
}

class CacheException implements Exception {
  const CacheException([this.message = "Cache exception"]);

  final String message;
}

class NetworkException implements Exception {
  const NetworkException([this.message = "No internet connection"]);

  final String message;
}

class UnknownException implements Exception {
  const UnknownException([this.message = "Unknown exception"]);

  final String message;
}
