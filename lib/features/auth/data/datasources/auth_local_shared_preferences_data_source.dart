import "package:flutter_application_1/core/error/failures.dart";
import "package:flutter_application_1/core/session/session.dart";
import "package:flutter_application_1/core/utils/either.dart";
import "package:shared_preferences/shared_preferences.dart";

import "auth_local_data_source.dart";

class AuthLocalSharedPreferencesDataSource implements AuthLocalDataSource {
  final SharedPreferences _sharedPreferences;

  final String _accessTokenKey = "auth:access_token";
  final String _refreshTokenKey = "auth:refresh_token";
  final String _accessExpiresAtKey = "auth:access_expires_at";
  final String _refreshExpiresAtKey = "auth:refresh_expires_at";
  final String _userIdKey = "auth:user_id";
  final String _userEmailKey = "auth:user_email";

  AuthLocalSharedPreferencesDataSource({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  @override
  Future<Either<Failure, AuthSessionAuthenticated>> readSession() async {
    final (
      accessToken,
      refreshToken,
      accessExpiresAt,
      refreshExpiresAt,
      userId,
      userEmail,
    ) = (
      _sharedPreferences.getString(_accessTokenKey),
      _sharedPreferences.getString(_refreshTokenKey),
      _sharedPreferences.getString(_accessExpiresAtKey),
      _sharedPreferences.getString(_refreshExpiresAtKey),
      _sharedPreferences.getString(_userIdKey),
      _sharedPreferences.getString(_userEmailKey),
    );

    if (accessToken == null ||
        refreshToken == null ||
        accessExpiresAt == null ||
        refreshExpiresAt == null ||
        userId == null ||
        userEmail == null) {
      return Left(
        const CacheFailure("Failed to read session from shared preferences"),
      );
    }

    return Right(
      AuthSessionAuthenticated(
        user: AuthUser(id: userId, email: userEmail),
        tokens: AuthTokens(
          accessToken: accessToken,
          refreshToken: refreshToken,
          accessExpiresAt: DateTime.fromMillisecondsSinceEpoch(
            accessExpiresAt.isNotEmpty
                ? int.parse(accessExpiresAt)
                : DateTime.now().millisecondsSinceEpoch,
          ),
          refreshExpiresAt: DateTime.fromMillisecondsSinceEpoch(
            refreshExpiresAt.isNotEmpty
                ? int.parse(refreshExpiresAt)
                : DateTime.now().millisecondsSinceEpoch,
          ),
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, void>> saveSession(
    AuthSessionAuthenticated session,
  ) async {
    try {
      await Future.wait<void>([
        _sharedPreferences.setString(
          _accessTokenKey,
          session.tokens.accessToken,
        ),
        _sharedPreferences.setString(
          _refreshTokenKey,
          session.tokens.refreshToken,
        ),
        _sharedPreferences.setString(
          _accessExpiresAtKey,
          session.tokens.accessExpiresAt.millisecondsSinceEpoch.toString(),
        ),
        _sharedPreferences.setString(
          _refreshExpiresAtKey,
          session.tokens.refreshExpiresAt.millisecondsSinceEpoch.toString(),
        ),
        _sharedPreferences.setString(_userIdKey, session.user.id),
        _sharedPreferences.setString(_userEmailKey, session.user.email),
      ]);

      return Right(null);
    } catch (e) {
      return Left(
        const CacheFailure("Failed to save session to shared preferences"),
      );
    }
  }

  @override
  Future<Either<Failure, void>> clearSession() async {
    try {
      await Future.wait<void>([
        _sharedPreferences.remove(_accessTokenKey),
        _sharedPreferences.remove(_refreshTokenKey),
        _sharedPreferences.remove(_accessExpiresAtKey),
        _sharedPreferences.remove(_refreshExpiresAtKey),
        _sharedPreferences.remove(_userIdKey),
        _sharedPreferences.remove(_userEmailKey),
      ]);

      return Right(null);
    } catch (e) {
      return Left(
        const CacheFailure("Failed to clear session from shared preferences"),
      );
    }
  }
}
