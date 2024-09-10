import 'util/env.dart';

class BalunConstants {
  static final baseUrl = Env.apiFootballBaseUrl;

  static const animationDuration = Duration(milliseconds: 125);
  static const buttonScaleDuration = Duration(milliseconds: 125);
  static const shimmerDuration = Duration(milliseconds: 1500);
  static const cacheDuration = Duration(days: 3);

  /// Keys are country names from the backend
  static const popularCountryIDs = [
    'World',
    'Croatia',
    'England',
    'Spain',
    'Germany',
    'Italy',
    'France',
  ];

  /// Keys are league IDs from the backend
  static const popularLeagueIDs = [
    1, // World Cup
    4, // Euro Championship
    5, // UEFA Nations League
    2, // UEFA Champions League
    3, // UEFA Europa League
    210, // HNL
    39, // Premier League
    140, // La Liga
    78, // Bundesliga
    135, // Serie A
    61, // Ligue 1
  ];
}
