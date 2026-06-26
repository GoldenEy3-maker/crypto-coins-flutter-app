part of "auth_bloc.dart";

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthAppStarted extends AuthEvent {}

class AuthLoginSubmitted extends AuthEvent {
  final LoginParams params;

  const AuthLoginSubmitted({required this.params});

  @override
  List<Object> get props => [...super.props, params];
}

class AuthLogoutRequested extends AuthEvent {}
