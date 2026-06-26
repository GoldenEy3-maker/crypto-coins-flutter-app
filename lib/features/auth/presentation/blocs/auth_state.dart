part of "auth_bloc.dart";

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthStatusUnknown extends AuthState {}

final class AuthStatusAuthenticated extends AuthState {
  final AuthUser user;

  const AuthStatusAuthenticated({required this.user});

  @override
  List<Object> get props => [...super.props, user];
}

final class AuthStatusUnauthenticated extends AuthState {}

final class AuthStatusLoading extends AuthState {}

final class AuthStatusFailure extends AuthState {
  final Failure failure;

  const AuthStatusFailure({required this.failure});

  @override
  List<Object> get props => [...super.props, failure];
}
