import "package:flutter_application_1/core/error/failures.dart";

import "package:flutter_application_1/core/session/auth_session.dart";

import "package:flutter_application_1/core/utils/either.dart";

import "../../domain/repositories/repositories.dart";
import "../../domain/params/params.dart";
import "../datasources/datasources.dart";
import "session_repository_impl.dart";

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;
  final SessionRepositoryImpl _sessionRepository;

  const AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
    required SessionRepositoryImpl sessionRepository,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource,
       _sessionRepository = sessionRepository;

  @override
  Future<Either<Failure, AuthSessionAuthenticated>> login(
    LoginParams params,
  ) async {
    final remoteLoginResult = await _remoteDataSource.login(params);

    return remoteLoginResult.fold((failure) => Left(failure), (session) async {
      final localSaveResult = await _localDataSource.saveSession(session);

      if (localSaveResult.isLeft()) {
        return Left(localSaveResult.leftOrNull!);
      }

      _sessionRepository.updateSession(session);
      return Right(session);
    });
  }

  @override
  Future<Either<Failure, void>> logout() async {
    final (remoteLogoutResult, _) = await (
      _remoteDataSource.logout(),
      _localDataSource.clearSession(),
    ).wait;

    return remoteLogoutResult.fold(
      (failure) async {
        _sessionRepository.updateSession(AuthSessionUnauthenticated());
        return Left(failure);
      },
      (success) async {
        _sessionRepository.updateSession(AuthSessionUnauthenticated());
        return Right(null);
      },
    );
  }

  @override
  Future<Either<Failure, AuthSession>> refreshTokens() async {
    final localSessionResult = await _localDataSource.readSession();

    return localSessionResult.fold(
      (failure) {
        _sessionRepository.updateSession(AuthSessionUnauthenticated());
        return Right(AuthSessionUnauthenticated());
      },
      (session) async {
        final remoteRefreshResult = await _remoteDataSource.refresh(
          session.tokens.refreshToken,
        );
        return remoteRefreshResult.fold(
          (failure) async {
            await _localDataSource.clearSession();
            _sessionRepository.updateSession(AuthSessionUnauthenticated());
            return Right(AuthSessionUnauthenticated());
          },
          (tokens) async {
            final localSaveResult = await _localDataSource.saveSession(
              AuthSessionAuthenticated(user: session.user, tokens: tokens),
            );

            if (localSaveResult.isLeft()) {
              _sessionRepository.updateSession(AuthSessionUnauthenticated());
              return Right(AuthSessionUnauthenticated());
            }

            final updatedSession = AuthSessionAuthenticated(
              user: session.user,
              tokens: tokens,
            );
            _sessionRepository.updateSession(updatedSession);

            return Right(updatedSession);
          },
        );
      },
    );
  }

  @override
  Future<Either<Failure, AuthSession>> restoreSession() async {
    final localSessionResult = await _localDataSource.readSession();
    return localSessionResult.fold(
      (failure) {
        _sessionRepository.updateSession(AuthSessionUnauthenticated());
        return Right(AuthSessionUnauthenticated());
      },
      (session) async {
        final isAccessTokenExpired = session.tokens.accessExpiresAt.isBefore(
          DateTime.now(),
        );
        final isRefreshTokenExpired = session.tokens.refreshExpiresAt.isBefore(
          DateTime.now(),
        );

        if (isRefreshTokenExpired) {
          await _localDataSource.clearSession();
          _sessionRepository.updateSession(AuthSessionUnauthenticated());
          return Right(AuthSessionUnauthenticated());
        }

        if (isAccessTokenExpired && !isRefreshTokenExpired) {
          final remoteRefreshResult = await _remoteDataSource.refresh(
            session.tokens.refreshToken,
          );

          return remoteRefreshResult.fold(
            (failure) async {
              await _localDataSource.clearSession();
              _sessionRepository.updateSession(AuthSessionUnauthenticated());
              return Right(AuthSessionUnauthenticated());
            },
            (tokens) async {
              final newSession = AuthSessionAuthenticated(
                user: session.user,
                tokens: tokens,
              );

              final localSaveResult = await _localDataSource.saveSession(
                newSession,
              );

              return localSaveResult.fold(
                (failure) {
                  _sessionRepository.updateSession(
                    AuthSessionUnauthenticated(),
                  );
                  return Right(AuthSessionUnauthenticated());
                },
                (_) {
                  _sessionRepository.updateSession(newSession);
                  return Right(newSession);
                },
              );
            },
          );
        }

        _sessionRepository.updateSession(session);
        return Right(session);
      },
    );
  }
}
