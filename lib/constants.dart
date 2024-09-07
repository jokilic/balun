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
    'Italy': 5,
    'Germany': 4,
    'France': 6,
  };

  // TODO: Update this with all values - https://dashboard.api-football.com/soccer/ids
  /// Keys are league IDs from the backend
  static const leaguesOrder = {
    210: 0,
    33: 1,
    11: 2,
    140: 3,
    212: 4,
  };
}
