import "package:flutter/material.dart";

abstract final class TalkerMobxKey {
  static const observable = "mobx-observable";
  static const action = "mobx-action";
  static const reaction = "mobx-reaction";
  static const reactionError = "mobx-reaction-error";

  static const List<String> all = [observable, action, reaction, reactionError];
}

/// Цвета карточек в [TalkerScreen] / [TalkerView] (см. [TalkerData.getFlutterColor]).
const Map<String, Color> talkerMobxFlutterLogColors = {
  TalkerMobxKey.observable: Color(0xFFFF9100),
  TalkerMobxKey.action: Color(0xFFFFB300),
  TalkerMobxKey.reaction: Color(0xFFFF6D00),
  TalkerMobxKey.reactionError: Color(0xFFEF5350),
};
