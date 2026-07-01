import "package:dio/dio.dart";
import "package:flutter_application_1/core/network/token_refresher.dart";
import "package:flutter_application_1/core/session/auth_session.dart";
import "package:flutter_application_1/core/session/session_repository.dart";

class AuthTokenInterceptor extends QueuedInterceptor {
  static const _authRetryExtraKey = "auth_retry";

  final SessionRepository _sessionRepository;
  final TokenRefresher _tokenRefresher;
  final Dio _retryDio;

  AuthTokenInterceptor({
    required Dio dio,
    required SessionRepository sessionRepository,
    required TokenRefresher tokenRefresher,
  }) : _sessionRepository = sessionRepository,
       _tokenRefresher = tokenRefresher,
       _retryDio = Dio(dio.options);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final session = _sessionRepository.currentSession;

    if (session is AuthSessionAuthenticated) {
      options.headers["Authorization"] = "Bearer ${session.tokens.accessToken}";
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.requestOptions.extra[_authRetryExtraKey] == true) {
      return handler.reject(err);
    }

    final isAuthRequest = err.requestOptions.uri.path.contains(
      RegExp(r"/auth/"),
    );
    final session = _sessionRepository.currentSession;
    final isAuthSession = session is AuthSessionAuthenticated;

    if (err.response?.statusCode != 401 || isAuthRequest || !isAuthSession) {
      return handler.reject(err);
    }

    final requestedAccessToken = err.requestOptions.headers["Authorization"]
        ?.split(" ")
        .last;

    if (requestedAccessToken == session.tokens.accessToken) {
      final refreshResult = await _tokenRefresher.refreshTokens();

      if (refreshResult.isLeft()) {
        return handler.reject(err);
      }
    }

    try {
      final retriedResult = await _retryDio.fetch(
        err.requestOptions.copyWith(
          headers: {
            ...err.requestOptions.headers,
            "Authorization": "Bearer ${session.tokens.accessToken}",
          },
          extra: {...err.requestOptions.extra, _authRetryExtraKey: true},
        ),
      );

      if (retriedResult.statusCode == null ||
          retriedResult.statusCode! ~/ 100 != 2) {
        return handler.reject(err);
      }

      return handler.resolve(retriedResult);
    } catch (_) {
      return handler.reject(err);
    }
  }
}
