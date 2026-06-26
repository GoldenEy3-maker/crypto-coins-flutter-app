import "auth_session.dart";

abstract interface class SessionRepository {
  Stream<AuthSession> get sessionChanges;
  AuthSession get currentSession;
}
