import "package:mobx/mobx.dart";
import "package:talker_flutter/talker_flutter.dart";

import "talker_mobx_spy_logger.dart";

void enableTalkerMobxLogger(Talker talker) {
  final talkerMobxLogger = TalkerMobxSpyLogger(talker: talker);

  mainContext.config = mainContext.config.clone(isSpyEnabled: true);

  mainContext.spy(talkerMobxLogger.handle);
}
