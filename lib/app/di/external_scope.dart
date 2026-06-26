import "package:flutter_application_1/core/di/get_it.dart";
import "package:flutter_application_1/core/logging/enable_talker_mobx_logger.dart";
import "package:flutter_application_1/core/logging/talker_factory.dart";
import "package:flutter_application_1/core/logging/talker_mobx_talker_setup.dart";
import "package:flutter_application_1/core/storage/flutter_secure_storage_initializer.dart";
import "package:flutter_application_1/core/storage/hive_initializer.dart";
import "package:flutter_application_1/core/storage/prefs_initializer.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:talker_flutter/talker_flutter.dart";

Future<void> registerExternalScope() async {
  const mobxSetup = TalkerMobxTalkerSetup();

  final talker = TalkerFactory(
    settings: mobxSetup.settings,
    setups: [mobxSetup.setup],
  ).create();

  getIt.registerSingleton<Talker>(talker);

  enableTalkerMobxLogger(talker);

  const prefsInitializer = PrefsInitializer();
  const hiveInitializer = HiveInitializer();
  const flutterSecureStorageInitializer = FlutterSecureStorageInitializer();

  final (prefs, hivePath) = await (
    prefsInitializer.init(),
    hiveInitializer.init(),
  ).wait;

  talker.info("SharedPreferences initialized");
  talker.info("Hive initialized in $hivePath");

  final flutterSecureStorage = flutterSecureStorageInitializer.init();
  talker.info("FlutterSecureStorage initialized");

  getIt.registerSingleton<SharedPreferences>(prefs);
  getIt.registerSingleton<FlutterSecureStorage>(flutterSecureStorage);
}
