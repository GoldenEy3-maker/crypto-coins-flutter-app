import "dart:async";

import "package:bloc/bloc.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:flutter_application_1/app/app.dart";
import "package:flutter_application_1/core/di/get_it.dart";
import "package:flutter_application_1/firebase_options.dart";
import "package:talker_bloc_logger/talker_bloc_logger.dart";
import "package:talker_flutter/talker_flutter.dart";

import "di/di.dart";
import "notification_service.dart";

Future<void> bootstrap() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await setupDI();

    Bloc.observer = TalkerBlocObserver(talker: getIt.get<Talker>());

    final firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    getIt.get<Talker>().info(
      "Firebase app initialized with project id: ${firebaseApp.options.projectId}",
    );

    FlutterError.onError = (details) =>
        getIt.get<Talker>().handle(details.exception, details.stack);

    runApp(const CoinsApp());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(
        NotificationService.instance.initialize(talker: getIt.get<Talker>()),
      );
    });
  }, (e, st) => getIt.get<Talker>().handle(e, st));
}
