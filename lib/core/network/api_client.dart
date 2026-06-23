import "package:dio/dio.dart";
import "package:flutter_application_1/core/network/dio_factory.dart";
import "package:talker_flutter/talker_flutter.dart" show Talker;

class ApiClient {
  ApiClient({required Dio dio}) : _dio = dio;

  final Dio _dio;

  Dio get client => _dio;

  factory ApiClient.withTalker({
    required Talker talker,
    DioFactory dioFactory = const DioFactory(),
  }) {
    return ApiClient(dio: dioFactory.create(talker: talker));
  }
}
