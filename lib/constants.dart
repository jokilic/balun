import 'models/leagues/league/league.dart';
import 'util/env.dart';

class BalunConstants {
  static final baseUrl = Env.apiFootballBaseUrl;

  static const animationDuration = Duration(milliseconds: 125);
  static const longAnimationDuration = Duration(milliseconds: 250);
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
  static final popularLeagues = [
    League(
      id: 1,
      name: 'World Cup',
      logo: '',
    ),
    League(
      id: 4,
      name: 'Euro Championship',
      logo: '',
    ),
    League(
      id: 5,
      name: 'UEFA Nations League',
      logo: '',
    ),
    League(
      id: 2,
      name: 'UEFA Champions League',
      logo: '',
    ),
    League(
      id: 3,
      name: 'UEFA Europa League',
      logo: '',
    ),
    League(
      id: 210,
      name: 'HNL',
      logo: '',
    ),
    League(
      id: 39,
      name: 'Premier League',
      logo: '',
    ),
    League(
      id: 140,
      name: 'La Liga',
      logo: '',
    ),
    League(
      id: 78,
      name: 'Bundesliga',
      logo: '',
    ),
    League(
      id: 135,
      name: 'Serie A',
      logo: '',
    ),
    League(
      id: 61,
      name: 'Ligue 1',
      logo: '',
    ),
  ];
}
