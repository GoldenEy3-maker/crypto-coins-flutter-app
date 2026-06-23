import "package:dio/dio.dart";
import "package:talker_flutter/talker_flutter.dart";

import "interceptors/talker_interceptor.dart";

class DioFactory {
  const DioFactory({
    this.connectTimeout = const Duration(seconds: 30),
    this.receiveTimeout = const Duration(seconds: 30),
    this.sendTimeout = const Duration(seconds: 30),
  });

  final Duration connectTimeout;
  final Duration receiveTimeout;
  final Duration sendTimeout;

  Dio create({
    required Talker talker,
    String? baseUrl,
    List<Interceptor> interceptors = const [],
    bool enableTalkerLogger = true,
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl ?? "",
        receiveTimeout: receiveTimeout,
        connectTimeout: connectTimeout,
        sendTimeout: sendTimeout,
      ),
    );

    dio.interceptors.addAll(interceptors);

    if (enableTalkerLogger) {
      dio.interceptors.add(TalkerInterceptor(talker: talker));
    }

    return dio;
  }
}
