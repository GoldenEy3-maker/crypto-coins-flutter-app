import "package:flutter_application_1/core/logging/talker_mobx_keys.dart";
import "package:mobx/mobx.dart";
import "package:talker_flutter/talker_flutter.dart";

class TalkerMobxSpySettings {
  final bool skipSetterShadowActions;

  final bool skipAnonymousActions;

  final bool skipAsyncActionZoneSlices;

  const TalkerMobxSpySettings({
    this.skipSetterShadowActions = true,
    this.skipAnonymousActions = true,
    this.skipAsyncActionZoneSlices = true,
  });
}

class TalkerMobxSpyLogger {
  late final Talker _talker;
  late final TalkerMobxSpySettings _settings;

  TalkerMobxSpyLogger({
    Talker? talker,
    TalkerMobxSpySettings settings = const TalkerMobxSpySettings(),
  }) : _settings = settings,
       _talker = talker ?? Talker();

  static final RegExp _anonymousAction = RegExp(r"^Action@\d+$");

  static bool _isSetterShadowAction(String name) => name.endsWith("_set");

  static bool _isAsyncZoneSlice(String name) =>
      name.contains("(Zone.run") || name.contains("Zone.runUnary");

  static bool _isAnonymousAction(String name) =>
      _anonymousAction.hasMatch(name);

  bool _isShowAction(String name) {
    if (_settings.skipSetterShadowActions && _isSetterShadowAction(name)) {
      return false;
    }
    if (_settings.skipAnonymousActions && _isAnonymousAction(name)) {
      return false;
    }
    if (_settings.skipAsyncActionZoneSlices && _isAsyncZoneSlice(name)) {
      return false;
    }

    return true;
  }

  void handle(SpyEvent event) {
    switch (event) {
      case final ReactionErrorSpyEvent e:
        _talker.logCustom(
          TalkerLog(
            "${e.name} · ${e.error}",
            key: TalkerMobxKey.reactionError,
            logLevel: LogLevel.error,
          ),
        );
      case final ObservableValueSpyEvent e:
        _talker.logCustom(
          TalkerLog(
            "${e.name}: ${_short(e.oldValue)} → ${_short(e.newValue)}",
            key: TalkerMobxKey.observable,
            logLevel: LogLevel.verbose,
          ),
        );
      case final EndedSpyEvent e when e.type == "action":
        if (_isShowAction(e.name)) {
          _talker.logCustom(
            TalkerLog(
              "${e.name} · ${e.duration?.inMilliseconds ?? 0}ms",
              key: TalkerMobxKey.action,
              logLevel: LogLevel.verbose,
            ),
          );
        }
      case final EndedSpyEvent e when e.type == "reaction":
        _talker.logCustom(
          TalkerLog(
            "${e.name} · ${e.duration?.inMilliseconds ?? 0}ms",
            key: TalkerMobxKey.reaction,
            logLevel: LogLevel.verbose,
          ),
        );
      default:
        break;
    }
  }

  static String _short(Object? v) {
    if (v == null) {
      return "null";
    }
    final s = v.toString();
    if (s.length > 120) {
      return "${s.substring(0, 117)}…";
    }
    return s;
  }
}
