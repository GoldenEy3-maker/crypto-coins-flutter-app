import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
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

  AuthBloc({
    required RestoreSession restoreSession,
    required Login login,
    required Logout logout,
  }) : _restoreSession = restoreSession,
       _login = login,
       _logout = logout,
       super(AuthStatusUnknown()) {
    on<AuthAppStarted>(_onAppStared);
    on<AuthLoginSubmitted>(_onLoginSubmitted);
    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onAppStared(
    AuthAppStarted event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthStatusLoading());

    final restoreSessionResult = await _restoreSession(const NoParams());

    restoreSessionResult.fold((failure) => emit(AuthStatusUnauthenticated()), (
      session,
    ) {
      switch (session) {
        case AuthSessionAuthenticated():
          emit(AuthStatusAuthenticated(user: session.user));
        case AuthSessionUnauthenticated():
          emit(AuthStatusUnauthenticated());
        case AuthSessionUnknown():
          emit(AuthStatusUnknown());
      }
    });
  }

  Future<void> _onLoginSubmitted(
    AuthLoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthStatusLoading());

    final loginResult = await _login(event.params);

    loginResult.fold(
      (failure) => emit(AuthStatusFailure(failure: failure)),
      (session) => emit(AuthStatusAuthenticated(user: session.user)),
    );
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthStatusLoading());

    final logoutResult = await _logout(const NoParams());

    logoutResult.fold(
      (failure) => emit(AuthStatusUnauthenticated()),
      (session) => emit(AuthStatusUnauthenticated()),
    );
  }
}
