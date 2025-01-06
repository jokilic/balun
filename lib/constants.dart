import 'models/leagues/league/league.dart';
import 'util/env.dart';

class BalunConstants {
  static final apiFootballBaseUrl = Env.apiFootballBaseUrl;

  static final cloudflareWorkersBaseUrl = Env.cloudflareWorkersBaseUrl;

  static final remoteSettingsBaseUrl = Env.remoteSettingsBaseUrl;
  static final remoteSettingsJsonUrl = Env.remoteSettingsJsonUrl;

  static final apiYouTubeDataBaseUrl = Env.apiYouTubeDataBaseUrl;
  static final apiYouTubeDataApiKey = Env.apiYouTubeDataApiKey;

  static const animationDuration = Duration(milliseconds: 125);
  static const longAnimationDuration = Duration(milliseconds: 250);
  static const buttonScaleDuration = Duration(milliseconds: 125);
  static const shimmerDuration = Duration(milliseconds: 1500);
  static const periodicAPICallDuration = Duration(minutes: 1);

  /// Keys are country names from the backend
  static const favoriteCountryIDs = [
    'World',
    'Croatia',
    'England',
    'Spain',
    'Germany',
    'Italy',
    'France',
  ];

  static String getLeaguesUrl(int leagueId) => 'https://media.api-sports.io/football/leagues/$leagueId.png';

  /// Keys are league IDs from the backend
  static final popularLeagues = [
    League(
      id: 1,
      name: 'World Cup',
      logo: getLeaguesUrl(1),
    ),
    League(
      id: 4,
      name: 'Euro Championship',
      logo: getLeaguesUrl(4),
    ),
    League(
      id: 5,
      name: 'UEFA Nations League',
      logo: getLeaguesUrl(5),
    ),
    League(
      id: 2,
      name: 'UEFA Champions League',
      logo: getLeaguesUrl(2),
    ),
    League(
      id: 3,
      name: 'UEFA Europa League',
      logo: getLeaguesUrl(3),
    ),
    League(
      id: 210,
      name: 'HNL',
      logo: getLeaguesUrl(210),
    ),
    League(
      id: 39,
      name: 'Premier League',
      logo: getLeaguesUrl(39),
    ),
    League(
      id: 140,
      name: 'La Liga',
      logo: getLeaguesUrl(140),
    ),
    League(
      id: 78,
      name: 'Bundesliga',
      logo: getLeaguesUrl(78),
    ),
    League(
      id: 135,
      name: 'Serie A',
      logo: getLeaguesUrl(135),
    ),
    League(
      id: 61,
      name: 'Ligue 1',
      logo: getLeaguesUrl(61),
    ),
  ];
}
