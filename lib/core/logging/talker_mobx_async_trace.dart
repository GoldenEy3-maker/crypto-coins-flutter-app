import "package:talker_flutter/talker_flutter.dart";

import "talker_mobx_keys.dart";

/// Ручной high-level лог для async `@action`, если нужен свой текст или тайминг
/// поверх [TalkerMobxSpySettings.summarizeAsyncSessions] (по умолчанию spy уже даёт `→` / `←`).
///
/// Вызовите [start] в начале метода и [TalkerMobxAsyncTrace.end] в `finally`:
/// ```dart
/// @action
/// Future<void> loadCoins() async {
///   final trace = TalkerMobxAsyncTrace.start(talker, 'loadCoins');
///   try {
///     // ...
///   } finally {
///     trace.end();
///   }
/// }
/// ```
final class TalkerMobxAsyncTrace {
  TalkerMobxAsyncTrace(this._talker, this._name, this._sw);

  final Talker _talker;
  final String _name;
  final Stopwatch _sw;

  static TalkerMobxAsyncTrace start(Talker talker, String name) {
    final sw = Stopwatch()..start();
    talker.logCustom(
      TalkerLog(
        "$name · async action start tracking",
        key: TalkerMobxKey.action,
        logLevel: LogLevel.verbose,
      ),
    );
    return TalkerMobxAsyncTrace(talker, name, sw);
  }

  void end() {
    _sw.stop();
    _talker.logCustom(
      TalkerLog(
        "$_name · async action end tracking in ${_sw.elapsedMilliseconds}ms",
        key: TalkerMobxKey.action,
        logLevel: LogLevel.verbose,
      ),
    );
  }
}
