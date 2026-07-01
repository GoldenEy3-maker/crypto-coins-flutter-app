part of "auth_bloc.dart";

enum AuthStatus { unknown, authenticated, unauthenticated }

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
    ValueGetter<AuthUser?>? user,
    ValueGetter<Failure?>? failure,
    bool? isLoading,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user != null ? user() : this.user,
      failure: failure != null ? failure() : this.failure,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [status, user, failure, isLoading];
}
