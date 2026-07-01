import "package:dio/dio.dart";

class DioFactory {
  final Duration connectTimeout;
  final Duration receiveTimeout;
  final Duration sendTimeout;

  const DioFactory({
    this.connectTimeout = const Duration(seconds: 30),
    this.receiveTimeout = const Duration(seconds: 30),
    this.sendTimeout = const Duration(seconds: 30),
  });

  Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: "",
        receiveTimeout: receiveTimeout,
        connectTimeout: connectTimeout,
        sendTimeout: sendTimeout,
      ),
    );

    return dio;
  }
}
