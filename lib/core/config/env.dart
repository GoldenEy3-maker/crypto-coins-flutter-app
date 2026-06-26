import "package:envied/envied.dart";

part "env.g.dart";

@Envied(path: ".env")
abstract class Env {
  @EnviedField(varName: "JSON_PLACEHOLDER_BASE_URL")
  static String jsonPlaceholderBaseUrl = _Env.jsonPlaceholderBaseUrl;

  @EnviedField(varName: "CRYPTOCOMPARE_BASE_URL")
  static const String cryptoCompareBaseUrl = _Env.cryptoCompareBaseUrl;

  @EnviedField(varName: "MOCK_AUTH_LOGIN_EMAIL")
  static const String mockAuthLoginEmail = _Env.mockAuthLoginEmail;

  @EnviedField(varName: "MOCK_AUTH_LOGIN_PASSWORD")
  static const String mockAuthLoginPassword = _Env.mockAuthLoginPassword;

  @EnviedField(varName: "ACCESS_TOKEN_SECRET", obfuscate: true)
  static const String accessTokenSecret = _Env.accessTokenSecret;

  @EnviedField(varName: "REFRESH_TOKEN_SECRET", obfuscate: true)
  static const String refreshTokenSecret = _Env.refreshTokenSecret;
}
