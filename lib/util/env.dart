import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'API_FOOTBALL_API_KEY', obfuscate: true)
  static final String apiFootballApiKey = _Env.apiFootballApiKey;

  @EnviedField(varName: 'API_FOOTBALL_BASE_URL', obfuscate: true)
  static final String apiFootballBaseUrl = _Env.apiFootballBaseUrl;

  @EnviedField(varName: 'CLOUDFLARE_WORKER_URL', obfuscate: true)
  static final String cloudflareWorkerUrl = _Env.cloudflareWorkerUrl;

  @EnviedField(varName: 'REMOTE_SETTINGS_BASE_URL', obfuscate: true)
  static final String remoteSettingsBaseUrl = _Env.remoteSettingsBaseUrl;

  @EnviedField(varName: 'REMOTE_SETTINGS_JSON_URL', obfuscate: true)
  static final String remoteSettingsJsonUrl = _Env.remoteSettingsJsonUrl;

  @EnviedField(varName: 'API_YOUTUBE_DATA_BASE_URL', obfuscate: true)
  static final String apiYouTubeDataBaseUrl = _Env.apiYouTubeDataBaseUrl;

  @EnviedField(varName: 'API_YOUTUBE_DATA_API_KEY', obfuscate: true)
  static final String apiYouTubeDataApiKey = _Env.apiYouTubeDataApiKey;

  @EnviedField(varName: 'SENTRY_DSN', obfuscate: true)
  static final String sentryDsn = _Env.sentryDsn;
}
