import "package:dart_jsonwebtoken/dart_jsonwebtoken.dart";
import "package:flutter_application_1/core/config/env.dart";
import "package:flutter_application_1/core/error/error_mapper.dart";
import "package:flutter_application_1/core/error/exceptions.dart";
import "package:flutter_application_1/core/error/failures.dart";

import "package:flutter_application_1/core/session/session.dart";

import "package:flutter_application_1/core/utils/either.dart";

import "../../domain/params/params.dart";
import "auth_remote_data_source.dart";

class JwtToken {
  final String token;
  final DateTime expiresAt;

  const JwtToken({required this.token, required this.expiresAt});
}

class JwtAccessTokenPayload {
  final String email;

  JwtAccessTokenPayload({required this.email});

  Map<String, dynamic> toJson() => {"email": email};

  factory JwtAccessTokenPayload.fromJson(Map<String, dynamic> json) {
    return JwtAccessTokenPayload(email: json["email"] as String);
  }
}

class JwtRefreshTokenPayload {
  final String email;
  final int tokenVersion;

  JwtRefreshTokenPayload({required this.email, required this.tokenVersion});

  Map<String, dynamic> toJson() => {
    "email": email,
    "tokenVersion": tokenVersion,
  };

  factory JwtRefreshTokenPayload.fromJson(Map<String, dynamic> json) {
    return JwtRefreshTokenPayload(
      email: json["email"] as String,
      tokenVersion: json["tokenVersion"] as int,
    );
  }
}

class AuthJwtTokenGenerator {
  static JwtToken generateAccessToken(JwtAccessTokenPayload payload) {
    final jwt = JWT(payload.toJson());
    final token = jwt.sign(
      SecretKey(Env.accessTokenSecret),
      expiresIn: const Duration(minutes: 5),
    );
    return JwtToken(
      token: token,
      expiresAt: DateTime.now().add(const Duration(seconds: 15)),
    );
  }

  static JwtToken generateRefreshToken(JwtRefreshTokenPayload payload) {
    final jwt = JWT(payload.toJson());
    final token = jwt.sign(
      SecretKey(Env.refreshTokenSecret),
      expiresIn: const Duration(days: 7),
    );
    return JwtToken(
      token: token,
      expiresAt: DateTime.now().add(const Duration(days: 7)),
    );
  }

  static Either<Exception, JwtAccessTokenPayload> verifyAccessToken(
    String token,
  ) {
    try {
      final jwt = JWT.verify(token, SecretKey(Env.accessTokenSecret));
      final payload = jwt.payload;
      return Right(JwtAccessTokenPayload.fromJson(payload));
    } catch (e) {
      return Left(JwtTokenException(e.toString()));
    }
  }

  static Either<Exception, JwtRefreshTokenPayload> verifyRefreshToken(
    String token,
  ) {
    try {
      final jwt = JWT.verify(token, SecretKey(Env.refreshTokenSecret));
      final payload = jwt.payload;
      return Right(JwtRefreshTokenPayload.fromJson(payload));
    } catch (e) {
      return Left(JwtTokenException(e.toString()));
    }
  }
}

class MockAuthRemoteDataSource implements AuthRemoteDataSource {
  @override
  Future<Either<Failure, AuthSessionAuthenticated>> login(LoginParams params) {
    return Future.delayed(const Duration(milliseconds: 500), () {
      if (params.email == Env.mockAuthLoginEmail &&
          params.password == Env.mockAuthLoginPassword) {
        final accessToken = AuthJwtTokenGenerator.generateAccessToken(
          JwtAccessTokenPayload(email: params.email),
        );
        final refreshToken = AuthJwtTokenGenerator.generateRefreshToken(
          JwtRefreshTokenPayload(
            email: params.email,
            tokenVersion: Env.mockAuthTokenVersion,
          ),
        );

        return Right(
          AuthSessionAuthenticated(
            user: AuthUser(id: "1", email: params.email),
            tokens: AuthTokens(
              accessToken: accessToken.token,
              refreshToken: refreshToken.token,
              accessExpiresAt: accessToken.expiresAt,
              refreshExpiresAt: refreshToken.expiresAt,
            ),
          ),
        );
      }

      return Left(const InvalidCredentialsFailure());
    });
  }

  @override
  Future<Either<Failure, void>> logout() {
    return Future.delayed(const Duration(milliseconds: 500), () {
      return Right(null);
    });
  }

  @override
  Future<Either<Failure, AuthTokens>> refresh(String refreshToken) {
    return Future.delayed(const Duration(milliseconds: 500), () {
      final refreshTokenResult = AuthJwtTokenGenerator.verifyRefreshToken(
        refreshToken,
      );

      return refreshTokenResult.fold(
        (exception) => Left(mapExceptionToFailure(exception)),
        (jwtToken) {
          if (jwtToken.tokenVersion != Env.mockAuthTokenVersion) {
            return Left(const UnauthorizedFailure());
          }

          final accessToken = AuthJwtTokenGenerator.generateAccessToken(
            JwtAccessTokenPayload(email: jwtToken.email),
          );
          final refreshToken = AuthJwtTokenGenerator.generateRefreshToken(
            JwtRefreshTokenPayload(
              email: jwtToken.email,
              tokenVersion: jwtToken.tokenVersion,
            ),
          );

          return Right(
            AuthTokens(
              accessToken: accessToken.token,
              refreshToken: refreshToken.token,
              accessExpiresAt: accessToken.expiresAt,
              refreshExpiresAt: refreshToken.expiresAt,
            ),
          );
        },
      );
    });
  }
}
