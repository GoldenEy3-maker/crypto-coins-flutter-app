import "package:flutter_application_1/core/logging/talker_mobx_keys.dart";
import "package:talker_flutter/talker_flutter.dart";

final class TalkerMobxTalkerSetup {
  const TalkerMobxTalkerSetup();

  TalkerSettings get settings => TalkerSettings(
    colors: {
      TalkerMobxKey.observable: AnsiPen()..xterm(208),
      TalkerMobxKey.action: AnsiPen()..xterm(214),
      TalkerMobxKey.reaction: AnsiPen()..xterm(202),
      TalkerMobxKey.reactionError: AnsiPen()..xterm(203),
    },
    titles: {
      TalkerMobxKey.observable: "mobx-observable",
      TalkerMobxKey.action: "mobx-action",
      TalkerMobxKey.reaction: "mobx-reaction",
      TalkerMobxKey.reactionError: "mobx-reaction-error",
    },
  );

  void setup(Talker talker) {
    talker.settings.registerKeys(TalkerMobxKey.all);
  }
}
