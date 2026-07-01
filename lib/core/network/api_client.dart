import "package:dio/dio.dart";

class ApiClient {
  ApiClient({required Dio dio}) : _dio = dio;

  final Dio _dio;

  Dio get client => _dio;
}
