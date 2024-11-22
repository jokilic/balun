import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'API_FOOTBALL_API_KEY', obfuscate: true)
  static final String apiFootballApiKey = _Env.apiFootballApiKey;

  @EnviedField(varName: 'API_FOOTBALL_BASE_URL', obfuscate: true)
  static final String apiFootballBaseUrl = _Env.apiFootballBaseUrl;

  @EnviedField(varName: 'REMOTE_SETTINGS_BASE_URL', obfuscate: true)
  static final String remoteSettingsBaseUrl = _Env.remoteSettingsBaseUrl;

  @EnviedField(varName: 'REMOTE_SETTINGS_JSON_URL', obfuscate: true)
  static final String remoteSettingsJsonUrl = _Env.remoteSettingsJsonUrl;
}
