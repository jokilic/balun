import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'RAPIDAPI_KEY', obfuscate: true)
  static final String rapidApiKey = _Env.rapidApiKey;

  @EnviedField(varName: 'RAPIDAPI_HOST', obfuscate: true)
  static final String rapidApiHost = _Env.rapidApiHost;

  @EnviedField(varName: 'RAPIDAPI_BASE_URL', obfuscate: true)
  static final String rapidApiBaseUrl = _Env.rapidApiBaseUrl;

  @EnviedField(varName: 'REMOTE_SETTINGS_BASE_URL', obfuscate: true)
  static final String remoteSettingsBaseUrl = _Env.remoteSettingsBaseUrl;

  @EnviedField(varName: 'REMOTE_SETTINGS_JSON_URL', obfuscate: true)
  static final String remoteSettingsJsonUrl = _Env.remoteSettingsJsonUrl;

  @EnviedField(varName: 'API_YOUTUBE_DATA_BASE_URL', obfuscate: true)
  static final String apiYouTubeDataBaseUrl = _Env.apiYouTubeDataBaseUrl;

  @EnviedField(varName: 'API_YOUTUBE_DATA_API_KEY', obfuscate: true)
  static final String apiYouTubeDataApiKey = _Env.apiYouTubeDataApiKey;

  @EnviedField(varName: 'NEWS_SEARCH_BASE_URL', obfuscate: true)
  static final String newsSearchBaseUrl = _Env.newsSearchBaseUrl;

  @EnviedField(varName: 'NEWS_SEARCH_API_KEY', obfuscate: true)
  static final String newsSearchApiKey = _Env.newsSearchApiKey;
}
