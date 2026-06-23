import "package:talker_dio_logger/talker_dio_logger.dart";
import "package:talker_flutter/talker_flutter.dart";

class TalkerInterceptor extends TalkerDioLogger {
  TalkerInterceptor({required Talker talker})
    : super(
        talker: talker,
        settings: const TalkerDioLoggerSettings(printRequestHeaders: true),
      );
}
