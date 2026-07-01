import "package:dio/dio.dart";
import "package:flutter_application_1/core/network/token_refresher.dart";
import "package:flutter_application_1/core/session/auth_session.dart";
import "package:flutter_application_1/core/session/session_repository.dart";

class AuthTokenInterceptor extends Interceptor {
  final SessionRepository _sessionRepository;
  final TokenRefresher _tokenRefresher;

  AuthTokenInterceptor({
    required SessionRepository sessionRepository,
    required TokenRefresher tokenRefresher,
  }) : _sessionRepository = sessionRepository,
       _tokenRefresher = tokenRefresher;

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
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    final refreshResult = await _tokenRefresher.refreshTokens();

    refreshResult.fold((failure) => handler.next(err), (session) {});
  }
}
