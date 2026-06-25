import "package:envied/envied.dart";

part "env.g.dart";

@Envied(path: ".env")
abstract class Env {
  @EnviedField(varName: "JSON_PLACEHOLDER_BASE_URL")
  static String jsonPlaceholderBaseUrl = _Env.jsonPlaceholderBaseUrl;

  @EnviedField(varName: "CRYPTOCOMPARE_BASE_URL")
  static const String cryptoCompareBaseUrl = _Env.cryptoCompareBaseUrl;
}
