import 'util/env.dart';

class BalunConstants {
  static const animationDuration = Duration(milliseconds: 250);
  static const buttonScaleDuration = Duration(milliseconds: 125);
  static const loadingDuration = Duration(milliseconds: 1500);
  static const cacheDuration = Duration(days: 3);

  // TODO: Update this with all values
  /// Keys are country names from the backend
  static const countriesOrder = {
    'World': 0,
    'Croatia': 1,
    'England': 2,
    'Spain': 3,
    'Italy': 5,
    'Germany': 4,
    'France': 6,
    // 'Netherlands': 7,
    // 'Portugal': 8,
  };

  // TODO: Update this with all values
  /// Keys are league IDs from the backend
  static const leaguesOrder = {
    210: 0,
    33: 1,
    11: 2,
  };
}

class BalunEndpoints {
  static final baseUrl = Env.apiFootballBaseUrl;
}

class BalunImages {
  static const placeholderIcon = 'assets/icons/placeholder_icon.png';
}
