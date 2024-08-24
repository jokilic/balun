import 'util/env.dart';

class BalunConstants {
  static const animationDuration = Duration(milliseconds: 250);
  static const buttonScaleDuration = Duration(milliseconds: 125);
  static const shimmerDuration = Duration(milliseconds: 1500);
  static const cacheDuration = Duration(days: 3);

  static const countriesOrder = {
    'World': 0,
    'Croatia': 1,
    'England': 2,
    'Spain': 3,
    'Germany': 4,
    'Italy': 5,
    'France': 6,
  };

  // TODO: Update this with all values
  static const leaguesOrder = {
    'HNL': 0,
    'World Cup': 1,
    'Euro Cup': 2,
  };
}

class BalunEndpoints {
  static final baseUrl = Env.apiFootballBaseUrl;
}

class BalunImages {
  // TODO: Proper placeholder image
  static const placeholderLogo = 'assets/icon.png';
}
