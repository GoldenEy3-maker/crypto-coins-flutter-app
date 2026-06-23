import "package:flutter_application_1/app/di/app_scope.dart";
import "package:flutter_application_1/app/di/core_scope.dart";
import "package:flutter_application_1/app/di/external_scope.dart";
import "package:flutter_application_1/app/di/feature_scope.dart";

Future<void> setupDI() async {
  await registerExternalScope();
  registerCoreScope();
  registerAppScope();
  registerFeatureScope();
}
