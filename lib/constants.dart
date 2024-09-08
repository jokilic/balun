import 'util/env.dart';

class BalunConstants {
  static final baseUrl = Env.apiFootballBaseUrl;

  static const animationDuration = Duration(milliseconds: 125);
  static const buttonScaleDuration = Duration(milliseconds: 125);
  static const shimmerDuration = Duration(milliseconds: 1500);
  static const cacheDuration = Duration(days: 3);

  /// Keys are country names from the backend
  static const countriesOrder = {
    'World': 0,
    'Croatia': 1,
    'England': 2,
    'Spain': 3,
    'Germany': 4,
    'Italy': 5,
    'France': 6,
  };

  /// Keys are league IDs from the backend
  static const leaguesOrder = {
    1: 0, // World Cup
    4: 1, // Euro Championship
    5: 2, // UEFA Nations League
    2: 3, // UEFA Champions League
    3: 4, // UEFA Europa League
    210: 5, // HNL
    39: 6, // Premier League
    140: 7, // La Liga
    78: 8, // Bundesliga
    135: 9, // Serie A
    61: 10, // Ligue 1
  };
}
