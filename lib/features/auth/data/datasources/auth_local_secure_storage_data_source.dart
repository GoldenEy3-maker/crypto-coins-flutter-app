import "package:flutter_application_1/core/error/failures.dart";
import "package:flutter_application_1/core/session/session.dart";
import "package:flutter_application_1/core/utils/either.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";

import "auth_local_data_source.dart";

class AuthLocalSecureStorageDataSource implements AuthLocalDataSource {
  final FlutterSecureStorage _secureStorage;

  final String _accessTokenKey = "auth:access_token";
  final String _refreshTokenKey = "auth:refresh_token";
  final String _accessExpiresAtKey = "auth:access_expires_at";
  final String _refreshExpiresAtKey = "auth:refresh_expires_at";
  final String _userIdKey = "auth:user_id";
  final String _userEmailKey = "auth:user_email";

  AuthLocalSecureStorageDataSource({
    required FlutterSecureStorage secureStorage,
  }) : _secureStorage = secureStorage;

  @override
  Future<Either<Failure, AuthSessionAuthenticated>> readSession() async {
    final (
      accessToken,
      refreshToken,
      accessExpiresAt,
      refreshExpiresAt,
      userId,
      userEmail,
    ) = await (
      _secureStorage.read(key: _accessTokenKey),
      _secureStorage.read(key: _refreshTokenKey),
      _secureStorage.read(key: _accessExpiresAtKey),
      _secureStorage.read(key: _refreshExpiresAtKey),
      _secureStorage.read(key: _userIdKey),
      _secureStorage.read(key: _userEmailKey),
    ).wait;

    if (accessToken == null ||
        refreshToken == null ||
        accessExpiresAt == null ||
        refreshExpiresAt == null ||
        userId == null ||
        userEmail == null) {
      return Left(
        const CacheFailure("Failed to read session from secure storage"),
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
        _secureStorage.write(
          key: _accessTokenKey,
          value: session.tokens.accessToken,
        ),
        _secureStorage.write(
          key: _refreshTokenKey,
          value: session.tokens.refreshToken,
        ),
        _secureStorage.write(
          key: _accessExpiresAtKey,
          value: session.tokens.accessExpiresAt.millisecondsSinceEpoch
              .toString(),
        ),
        _secureStorage.write(
          key: _refreshExpiresAtKey,
          value: session.tokens.refreshExpiresAt.millisecondsSinceEpoch
              .toString(),
        ),
        _secureStorage.write(key: _userIdKey, value: session.user.id),
        _secureStorage.write(key: _userEmailKey, value: session.user.email),
      ]);

      return Right(null);
    } catch (e) {
      return Left(
        const CacheFailure("Failed to save session to secure storage"),
      );
    }
  }

  @override
  Future<Either<Failure, void>> clearSession() async {
    try {
      await Future.wait<void>([
        _secureStorage.delete(key: _accessTokenKey),
        _secureStorage.delete(key: _refreshTokenKey),
        _secureStorage.delete(key: _accessExpiresAtKey),
        _secureStorage.delete(key: _refreshExpiresAtKey),
        _secureStorage.delete(key: _userIdKey),
        _secureStorage.delete(key: _userEmailKey),
      ]);

      return Right(null);
    } catch (e) {
      return Left(
        const CacheFailure("Failed to clear session from secure storage"),
      );
    }
  }
}
