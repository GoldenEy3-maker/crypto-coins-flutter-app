import "auth_tokens.dart";
import "auth_user.dart";

sealed class AuthSession {}

class AuthSessionUnknown extends AuthSession {}

class AuthSessionAuthenticated extends AuthSession {
  final AuthUser user;
  final AuthTokens tokens;

  AuthSessionAuthenticated({required this.user, required this.tokens});
}

class AuthSessionUnauthenticated extends AuthSession {}
