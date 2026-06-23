import "package:flutter/material.dart";
import "package:flutter_application_1/core/logging/talker_mobx_keys.dart";
import "package:talker_flutter/talker_flutter.dart";

class CustomTalkerScreen extends StatelessWidget {
  final Talker talker;

  const CustomTalkerScreen({super.key, required this.talker});

  @override
  Widget build(BuildContext context) {
    return TalkerScreen(
      talker: talker,
      isLogsExpanded: false,
      theme: const TalkerScreenTheme(logColors: talkerMobxFlutterLogColors),
    );
  }
}
