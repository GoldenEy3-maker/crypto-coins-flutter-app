import "package:dio/dio.dart";
import "package:flutter_application_1/core/error/failures.dart";

Failure mapDioException(DioException exception) {
  return switch (exception.type) {
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout ||
    DioExceptionType.connectionError =>
      NetworkFailure(exception.message ?? "No internet connection"),
    DioExceptionType.badResponse => ServerFailure(
      "HTTP ${exception.response?.statusCode ?? "unknown"}",
    ),
    _ => ServerFailure(exception.message ?? "Server exception"),
  };
}
