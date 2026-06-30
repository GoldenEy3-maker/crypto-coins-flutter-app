part of "auth_bloc.dart";

enum AuthStatus { unknown, authenticated, unauthenticated }

const _absent = Object();

class AuthState extends Equatable {
  final AuthStatus status;
  final AuthUser? user;
  final Failure? failure;
  final bool isLoading;

  const AuthState({
    this.status = AuthStatus.unknown,
    this.user,
    this.failure,
    this.isLoading = false,
  });

  AuthState copyWith({
    AuthStatus? status,
    Object? user = _absent,
    Object? failure = _absent,
    bool? isLoading,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user == _absent ? this.user : user as AuthUser?,
      failure: failure == _absent ? this.failure : failure as Failure?,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [status, user, failure, isLoading];
}
