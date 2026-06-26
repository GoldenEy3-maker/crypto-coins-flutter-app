import "dart:async";

import "package:flutter_application_1/core/session/session.dart";

class AuthSessionRepository implements SessionRepository {
  AuthSessionRepository({AuthSession? initialSession})
    : _currentSession = initialSession ?? AuthSessionUnknown(),
      _controller = StreamController<AuthSession>.broadcast();

  AuthSession _currentSession;
  final StreamController<AuthSession> _controller;

  @override
  AuthSession get currentSession => _currentSession;

  @override
  Stream<AuthSession> get sessionChanges => _controller.stream;

  void updateSession(AuthSession session) {
    _currentSession = session;
    if (!_controller.isClosed) {
      _controller.add(session);
    }
  }

  void dispose() {
    _controller.close();
  }
}
