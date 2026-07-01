import "dart:async";

import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
import "package:flutter/foundation.dart";
import "package:flutter_application_1/core/error/failures.dart";
import "package:flutter_application_1/core/session/session.dart";
import "package:flutter_application_1/core/usecase/usecase.dart";

import "../../domain/params/params.dart";
import "../../domain/usecases/usecases.dart";

part "auth_event.dart";
part "auth_state.dart";

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RestoreSession _restoreSession;
  final Login _login;
  final Logout _logout;
  final SessionRepository _sessionRepository;
  StreamSubscription<AuthSession>? _sessionSubscription;

  AuthBloc({
    required SessionRepository sessionRepository,
    required RestoreSession restoreSession,
    required Login login,
    required Logout logout,
  }) : _sessionRepository = sessionRepository,
       _restoreSession = restoreSession,
       _login = login,
       _logout = logout,
       super(const AuthState(status: AuthStatus.unknown)) {
    on<AuthAppStarted>(_onAppStared);
    on<AuthLoginSubmitted>(_onLoginSubmitted);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthSessionChanged>(_onSessionChanged);

    _sessionSubscription = _sessionRepository.sessionChanges.listen(
      (session) => add(AuthSessionChanged(session)),
    );
  }

  Future<void> _onAppStared(
    AuthAppStarted event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final restoreSessionResult = await _restoreSession(const NoParams());

    restoreSessionResult.fold(
      (failure) => emit(
        state.copyWith(status: AuthStatus.unauthenticated, isLoading: false),
      ),
      (session) {
        switch (session) {
          case AuthSessionAuthenticated():
            emit(
              state.copyWith(
                status: AuthStatus.authenticated,
                user: () => session.user,
                isLoading: false,
              ),
            );
          case AuthSessionUnauthenticated():
            emit(
              state.copyWith(
                status: AuthStatus.unauthenticated,
                isLoading: false,
              ),
            );
          case AuthSessionUnknown():
            emit(state.copyWith(status: AuthStatus.unknown, isLoading: false));
        }
      },
    );
  }

  Future<void> _onLoginSubmitted(
    AuthLoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, failure: () => null));

    final loginResult = await _login(event.params);

    loginResult.fold(
      (failure) =>
          emit(state.copyWith(failure: () => failure, isLoading: false)),
      (session) => emit(
        state.copyWith(
          status: AuthStatus.authenticated,
          user: () => session.user,
          isLoading: false,
          failure: () => null,
        ),
      ),
    );
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    await _logout(const NoParams());

    emit(
      state.copyWith(
        status: AuthStatus.unauthenticated,
        isLoading: false,
        user: () => null,
      ),
    );
  }

  Future<void> _onSessionChanged(
    AuthSessionChanged event,
    Emitter<AuthState> emit,
  ) async {
    switch (event.session) {
      case AuthSessionUnknown():
        emit(state.copyWith(status: AuthStatus.unknown, isLoading: false));
      case AuthSessionAuthenticated(:final user):
        emit(
          state.copyWith(
            status: AuthStatus.authenticated,
            user: () => user,
            isLoading: false,
          ),
        );
      case AuthSessionUnauthenticated():
        emit(
          state.copyWith(
            status: AuthStatus.unauthenticated,
            user: () => null,
            isLoading: false,
          ),
        );
    }
  }

  @override
  Future<void> close() {
    _sessionSubscription?.cancel();
    return super.close();
  }
}
