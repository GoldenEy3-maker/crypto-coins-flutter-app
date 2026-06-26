import "package:flutter_application_1/app/di/app_scope.dart";
import "package:flutter_application_1/app/di/core_scope.dart";
import "package:flutter_application_1/app/di/external_scope.dart";
import "package:flutter_application_1/features/auth/di/di.dart";
import "package:flutter_application_1/features/crypto/di/crypto_di.dart";
import "package:flutter_application_1/features/posts/di/posts_di.dart";

Future<void> setupDI() async {
  await registerExternalScope();
  registerCoreScope();
  registerAppScope();
  registerCryptoModule();
  registerPostsModule();
  registerAuthModule();
}
