import 'dart:async';

import 'package:dio/dio.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../models/coaches/coaches_response.dart';
import '../models/countries/countries_response.dart';
import '../models/fixtures/fixtures_response.dart';
import '../models/leagues/leagues_response.dart';
import '../models/player_teams/player_teams_response.dart';
import '../models/players/players_response.dart';
import '../models/search/search_coaches/search_coaches_response.dart';
import '../models/search/search_countries/search_countries_response.dart';
import '../models/search/search_leagues/search_leagues_response.dart';
import '../models/search/search_players/search_players_response.dart';
import '../models/search/search_teams/search_teams_response.dart';
import '../models/sidelined/sidelined_response.dart';
import '../models/squads/squads_response.dart';
import '../models/standings/standings_response.dart';
import '../models/status/status_response.dart';
import '../models/teams/teams_response.dart';
import '../models/transfers/transfers_response.dart';
import '../models/trophies/trophies_response.dart';
import '../util/isolates.dart';
import 'logger_service.dart';

class APIService {
  final LoggerService logger;
  final Dio dio;
  final InternetConnection internetConnection;

  APIService({
    required this.logger,
    required this.dio,
    required this.internetConnection,
  });

  ///
  /// `/status`
  ///

  Future<({StatusResponse? statusResponse, String? error})> getStatus() async {
    try {
      final response = await dio.get(
        '/status',
      );

      /// Handle status codes
      switch (response.statusCode) {
        /// Response is successful
        case 200:
        case 304:
          try {
            final parsedResponse = await computeStatus(response.data);
            return (statusResponse: parsedResponse, error: null);
          } catch (e) {
            final error = 'API -> getStatus -> parsing error -> $e';
            logger.e(error);
            return (statusResponse: null, error: error);
          }

        /// Response is not successful
        default:
          final error = 'API -> getStatus -> StatusCode ${response.statusCode}';
          logger.e(error);

          return (statusResponse: null, error: error);
      }
    } catch (e) {
      final error = await handleCatch(
        methodName: 'getStatus',
        mainError: '$e',
      );

      return (statusResponse: null, error: error);
    }
  }

  ///
  /// `/countries`
  ///

  Future<({CountriesResponse? countriesResponse, String? error})> getCountries() async {
    try {
      final response = await dio.get(
        '/countries',
      );

      /// Handle status codes
      switch (response.statusCode) {
        /// Response is successful
        case 200:
        case 304:
          try {
            final parsedResponse = await computeCountries(response.data);
            return (countriesResponse: parsedResponse, error: null);
          } catch (e) {
            final error = 'API -> getCountries -> parsing error -> $e';
            logger.e(error);
            return (countriesResponse: null, error: error);
          }

        /// Response is not successful
        default:
          final error = 'API -> getCountries -> StatusCode ${response.statusCode}';
          logger.e(error);

          return (countriesResponse: null, error: error);
      }
    } catch (e) {
      final error = await handleCatch(
        methodName: 'getCountries',
        mainError: '$e',
      );

      return (countriesResponse: null, error: error);
    }
  }

  ///
  /// `/fixtures`
  ///

  Future<({FixturesResponse? fixturesResponse, String? error})> getFixturesFromDate({
    required String dateString,
  }) async {
    try {
      final response = await dio.get(
        '/fixtures',
        queryParameters: {
          'date': dateString,
        },
      );

      /// Handle status codes
      switch (response.statusCode) {
        /// Response is successful
        case 200:
        case 304:
          try {
            final parsedResponse = await computeFixtures(response.data);
            return (fixturesResponse: parsedResponse, error: null);
          } catch (e) {
            final error = 'API -> getFixtures -> parsing error -> $e';
            logger.e(error);

            return (fixturesResponse: null, error: error);
          }

        /// Response is not successful
        default:
          final error = 'API -> getFixtures -> StatusCode ${response.statusCode}';
          logger.e(error);

          return (fixturesResponse: null, error: error);
      }
    } catch (e) {
      final error = await handleCatch(
        methodName: 'getFixtures',
        mainError: '$e',
      );

      return (fixturesResponse: null, error: error);
    }
  }

  Future<({FixturesResponse? fixturesResponse, String? error})> getFixturesFromLeagueAndSeason({
    required int leagueId,
    required String season,
  }) async {
    try {
      final response = await dio.get(
        '/fixtures',
        queryParameters: {
          'league': leagueId,
          'season': season,
        },
      );

      /// Handle status codes
      switch (response.statusCode) {
        /// Response is successful
        case 200:
        case 304:
          try {
            final parsedResponse = await computeFixtures(response.data);
            return (fixturesResponse: parsedResponse, error: null);
          } catch (e) {
            final error = 'API -> getFixturesFromLeagueAndSeason -> parsing error -> $e';
            logger.e(error);

            return (fixturesResponse: null, error: error);
          }

        /// Response is not successful
        default:
          final error = 'API -> getFixturesFromLeagueAndSeason -> StatusCode ${response.statusCode}';
          logger.e(error);

          return (fixturesResponse: null, error: error);
      }
    } catch (e) {
      final error = await handleCatch(
        methodName: 'getFixturesFromLeagueAndSeason',
        mainError: '$e',
      );

      return (fixturesResponse: null, error: error);
    }
  }

  Future<({FixturesResponse? fixturesResponse, String? error})> getFixturesFromTeam({
    required int teamId,
    int? lastNumber,
    int? nextNumber,
  }) async {
    try {
      final response = await dio.get(
        '/fixtures',
        queryParameters: {
          'team': teamId,
          if (lastNumber != null) 'last': lastNumber,
          if (nextNumber != null) 'next': nextNumber,
        },
      );

      /// Handle status codes
      switch (response.statusCode) {
        /// Response is successful
        case 200:
        case 304:
          try {
            final parsedResponse = await computeFixtures(response.data);
            return (fixturesResponse: parsedResponse, error: null);
          } catch (e) {
            final error = 'API -> getFixturesFromTeam -> parsing error -> $e';
            logger.e(error);

            return (fixturesResponse: null, error: error);
          }

        /// Response is not successful
        default:
          final error = 'API -> getFixturesFromTeam -> StatusCode ${response.statusCode}';
          logger.e(error);

          return (fixturesResponse: null, error: error);
      }
    } catch (e) {
      final error = await handleCatch(
        methodName: 'getFixturesFromTeam',
        mainError: '$e',
      );

      return (fixturesResponse: null, error: error);
    }
  }

  Future<({FixturesResponse? fixturesResponse, String? error})> getMatch({
    required int matchId,
  }) async {
    try {
      final response = await dio.get(
        '/fixtures',
        queryParameters: {
          'id': matchId,
        },
      );

      /// Handle status codes
      switch (response.statusCode) {
        /// Response is successful
        case 200:
        case 304:
          try {
            final parsedResponse = await computeFixtures(response.data);
            return (fixturesResponse: parsedResponse, error: null);
          } catch (e) {
            final error = 'API -> getMatch -> parsing error -> $e';
            logger.e(error);

            return (fixturesResponse: null, error: error);
          }

        /// Response is not successful
        default:
          final error = 'API -> getMatch -> StatusCode ${response.statusCode}';
          logger.e(error);

          return (fixturesResponse: null, error: error);
      }
    } catch (e) {
      final error = await handleCatch(
        methodName: 'getMatch',
        mainError: '$e',
      );

      return (fixturesResponse: null, error: error);
    }
  }

  ///
  /// `/fixtures/headtohead`
  ///

  Future<({FixturesResponse? head2HeadResponse, String? error})> getHead2Head({
    required int homeTeamId,
    required int awayTeamId,
  }) async {
    try {
      final response = await dio.get(
        '/fixtures/headtohead',
        queryParameters: {
          'h2h': '$homeTeamId-$awayTeamId',
        },
      );

      /// Handle status codes
      switch (response.statusCode) {
        /// Response is successful
        case 200:
        case 304:
          try {
            final parsedResponse = await computeFixtures(response.data);
            return (head2HeadResponse: parsedResponse, error: null);
          } catch (e) {
            final error = 'API -> getHead2Head -> parsing error -> $e';
            logger.e(error);

            return (head2HeadResponse: null, error: error);
          }

        /// Response is not successful
        default:
          final error = 'API -> getHead2Head -> StatusCode ${response.statusCode}';
          logger.e(error);

          return (head2HeadResponse: null, error: error);
      }
    } catch (e) {
      final error = await handleCatch(
        methodName: 'getHead2Head',
        mainError: '$e',
      );

      return (head2HeadResponse: null, error: error);
    }
  }

  ///
  /// `/teams`
  ///

  Future<({TeamsResponse? teamsResponse, String? error})> getTeam({
    required int teamId,
  }) async {
    try {
      final response = await dio.get(
        '/teams',
        queryParameters: {
          'id': teamId,
        },
      );

      /// Handle status codes
      switch (response.statusCode) {
        /// Response is successful
        case 200:
        case 304:
          try {
            final parsedResponse = await computeTeams(response.data);
            return (teamsResponse: parsedResponse, error: null);
          } catch (e) {
            final error = 'API -> getTeam -> parsing error -> $e';
            logger.e(error);

            return (teamsResponse: null, error: error);
          }

        /// Response is not successful
        default:
          final error = 'API -> getTeam -> StatusCode ${response.statusCode}';
          logger.e(error);

          return (teamsResponse: null, error: error);
      }
    } catch (e) {
      final error = await handleCatch(
        methodName: 'getTeam',
        mainError: '$e',
      );

      return (teamsResponse: null, error: error);
    }
  }

  Future<({TeamsResponse? teamsResponse, String? error})> getTeamsFromLeagueAndSeason({
    required int leagueId,
    required String season,
  }) async {
    try {
      final response = await dio.get(
        '/teams',
        queryParameters: {
          'league': leagueId,
          'season': season,
        },
      );

      /// Handle status codes
      switch (response.statusCode) {
        /// Response is successful
        case 200:
        case 304:
          try {
            final parsedResponse = await computeTeams(response.data);
            return (teamsResponse: parsedResponse, error: null);
          } catch (e) {
            final error = 'API -> getTeamsFromLeagueAndSeason -> parsing error -> $e';
            logger.e(error);

            return (teamsResponse: null, error: error);
          }

        /// Response is not successful
        default:
          final error = 'API -> getTeamsFromLeagueAndSeason -> StatusCode ${response.statusCode}';
          logger.e(error);

          return (teamsResponse: null, error: error);
      }
    } catch (e) {
      final error = await handleCatch(
        methodName: 'getTeamsFromLeagueAndSeason',
        mainError: '$e',
      );

      return (teamsResponse: null, error: error);
    }
  }

  ///
  /// `/standings`
  ///

  Future<({StandingsResponse? standingsResponse, String? error})> getStandingsFromLeague({
    required int leagueId,
    required String season,
  }) async {
    try {
      final response = await dio.get(
        '/standings',
        queryParameters: {
          'league': leagueId,
          'season': season,
        },
      );

      /// Handle status codes
      switch (response.statusCode) {
        /// Response is successful
        case 200:
        case 304:
          try {
            final parsedResponse = await computeStandings(response.data);
            return (standingsResponse: parsedResponse, error: null);
          } catch (e) {
            final error = 'API -> getStandingsFromLeague -> parsing error -> $e';
            logger.e(error);

            return (standingsResponse: null, error: error);
          }

        /// Response is not successful
        default:
          final error = 'API -> getStandingsFromLeague -> StatusCode ${response.statusCode}';
          logger.e(error);

          return (standingsResponse: null, error: error);
      }
    } catch (e) {
      final error = await handleCatch(
        methodName: 'getStandingsFromLeague',
        mainError: '$e',
      );

      return (standingsResponse: null, error: error);
    }
  }

  Future<({StandingsResponse? standingsResponse, String? error})> getStandingsFromTeam({
    required int teamId,
    required String season,
  }) async {
    try {
      final response = await dio.get(
        '/standings',
        queryParameters: {
          'team': teamId,
          'season': season,
        },
      );

      /// Handle status codes
      switch (response.statusCode) {
        /// Response is successful
        case 200:
        case 304:
          try {
            final parsedResponse = await computeStandings(response.data);
            return (standingsResponse: parsedResponse, error: null);
          } catch (e) {
            final error = 'API -> getStandingsFromTeam -> parsing error -> $e';
            logger.e(error);

            return (standingsResponse: null, error: error);
          }

        /// Response is not successful
        default:
          final error = 'API -> getStandingsFromTeam -> StatusCode ${response.statusCode}';
          logger.e(error);

          return (standingsResponse: null, error: error);
      }
    } catch (e) {
      final error = await handleCatch(
        methodName: 'getStandingsFromTeam',
        mainError: '$e',
      );

      return (standingsResponse: null, error: error);
    }
  }

  ///
  /// `/leagues`
  ///

  Future<({LeaguesResponse? leaguesResponse, String? error})> getLeague({
    required int leagueId,
  }) async {
    try {
      final response = await dio.get(
        '/leagues',
        queryParameters: {
          'id': leagueId,
        },
      );

      /// Handle status codes
      switch (response.statusCode) {
        /// Response is successful
        case 200:
        case 304:
          try {
            final parsedResponse = await computeLeagues(response.data);
            return (leaguesResponse: parsedResponse, error: null);
          } catch (e) {
            final error = 'API -> getLeague -> parsing error -> $e';
            logger.e(error);

            return (leaguesResponse: null, error: error);
          }

        /// Response is not successful
        default:
          final error = 'API -> getLeague -> StatusCode ${response.statusCode}';
          logger.e(error);

          return (leaguesResponse: null, error: error);
      }
    } catch (e) {
      final error = await handleCatch(
        methodName: 'getLeague',
        mainError: '$e',
      );

      return (leaguesResponse: null, error: error);
    }
  }

  Future<({LeaguesResponse? leaguesResponse, String? error})> getLeaguesFromTeam({
    required int teamId,
  }) async {
    try {
      final response = await dio.get(
        '/leagues',
        queryParameters: {
          'team': teamId,
        },
      );

      /// Handle status codes
      switch (response.statusCode) {
        /// Response is successful
        case 200:
        case 304:
          try {
            final parsedResponse = await computeLeagues(response.data);
            return (leaguesResponse: parsedResponse, error: null);
          } catch (e) {
            final error = 'API -> getLeaguesFromTeam -> parsing error -> $e';
            logger.e(error);

            return (leaguesResponse: null, error: error);
          }

        /// Response is not successful
        default:
          final error = 'API -> getLeaguesFromTeam -> StatusCode ${response.statusCode}';
          logger.e(error);

          return (leaguesResponse: null, error: error);
      }
    } catch (e) {
      final error = await handleCatch(
        methodName: 'getLeaguesFromTeam',
        mainError: '$e',
      );

      return (leaguesResponse: null, error: error);
    }
  }

  Future<({LeaguesResponse? leaguesResponse, String? error})> getLeaguesFromCountry({
    required String country,
  }) async {
    try {
      final response = await dio.get(
        '/leagues',
        queryParameters: {
          'country': country,
        },
      );

      /// Handle status codes
      switch (response.statusCode) {
        /// Response is successful
        case 200:
        case 304:
          try {
            final parsedResponse = await computeLeagues(response.data);
            return (leaguesResponse: parsedResponse, error: null);
          } catch (e) {
            final error = 'API -> getLeaguesFromCountry -> parsing error -> $e';
            logger.e(error);

            return (leaguesResponse: null, error: error);
          }

        /// Response is not successful
        default:
          final error = 'API -> getLeaguesFromCountry -> StatusCode ${response.statusCode}';
          logger.e(error);

          return (leaguesResponse: null, error: error);
      }
    } catch (e) {
      final error = await handleCatch(
        methodName: 'getLeaguesFromCountry',
        mainError: '$e',
      );

      return (leaguesResponse: null, error: error);
    }
  }

  ///
  /// `/players`
  ///

  Future<({PlayersResponse? playersResponse, String? error})> getPlayer({
    required int playerId,
    required String season,
  }) async {
    try {
      final response = await dio.get(
        '/players',
        queryParameters: {
          'id': playerId,
          'season': season,
        },
      );

      /// Handle status codes
      switch (response.statusCode) {
        /// Response is successful
        case 200:
        case 304:
          try {
            final parsedResponse = await computePlayers(response.data);
            return (playersResponse: parsedResponse, error: null);
          } catch (e) {
            final error = 'API -> getPlayer -> parsing error -> $e';
            logger.e(error);

            return (playersResponse: null, error: error);
          }

        /// Response is not successful
        default:
          final error = 'API -> getPlayer -> StatusCode ${response.statusCode}';
          logger.e(error);

          return (playersResponse: null, error: error);
      }
    } catch (e) {
      final error = await handleCatch(
        methodName: 'getPlayer',
        mainError: '$e',
      );

      return (playersResponse: null, error: error);
    }
  }

  ///
  /// `/players/teams`
  ///

  Future<({PlayerTeamsResponse? playerTeamsResponse, String? error})> getPlayerTeams({
    required int playerId,
  }) async {
    try {
      final response = await dio.get(
        '/players/teams',
        queryParameters: {
          'player': playerId,
        },
      );

      /// Handle status codes
      switch (response.statusCode) {
        /// Response is successful
        case 200:
        case 304:
          try {
            final parsedResponse = await computePlayerTeams(response.data);
            return (playerTeamsResponse: parsedResponse, error: null);
          } catch (e) {
            final error = 'API -> getPlayerTeams -> parsing error -> $e';
            logger.e(error);

            return (playerTeamsResponse: null, error: error);
          }

        /// Response is not successful
        default:
          final error = 'API -> getPlayerTeams -> StatusCode ${response.statusCode}';
          logger.e(error);

          return (playerTeamsResponse: null, error: error);
      }
    } catch (e) {
      final error = await handleCatch(
        methodName: 'getPlayerTeams',
        mainError: '$e',
      );

      return (playerTeamsResponse: null, error: error);
    }
  }

  ///
  /// `/players/squads`
  ///

  Future<({SquadsResponse? squadsResponse, String? error})> getPlayersFromTeam({
    required int teamId,
  }) async {
    try {
      final response = await dio.get(
        '/players/squads',
        queryParameters: {
          'team': teamId,
        },
      );

      /// Handle status codes
      switch (response.statusCode) {
        /// Response is successful
        case 200:
        case 304:
          try {
            final parsedResponse = await computeSquads(response.data);
            return (squadsResponse: parsedResponse, error: null);
          } catch (e) {
            final error = 'API -> getPlayersFromTeam -> parsing error -> $e';
            logger.e(error);

            return (squadsResponse: null, error: error);
          }

        /// Response is not successful
        default:
          final error = 'API -> getPlayersFromTeam -> StatusCode ${response.statusCode}';
          logger.e(error);

          return (squadsResponse: null, error: error);
      }
    } catch (e) {
      final error = await handleCatch(
        methodName: 'getPlayersFromTeam',
        mainError: '$e',
      );

      return (squadsResponse: null, error: error);
    }
  }

  ///
  /// `/players/topscorers`
  ///

  Future<({PlayersResponse? playersResponse, String? error})> getTopScorers({
    required int leagueId,
    required String season,
  }) async {
    try {
      final response = await dio.get(
        '/players/topscorers',
        queryParameters: {
          'league': leagueId,
          'season': season,
        },
      );

      /// Handle status codes
      switch (response.statusCode) {
        /// Response is successful
        case 200:
        case 304:
          try {
            final parsedResponse = await computePlayers(response.data);
            return (playersResponse: parsedResponse, error: null);
          } catch (e) {
            final error = 'API -> getTopScorers -> parsing error -> $e';
            logger.e(error);

            return (playersResponse: null, error: error);
          }

        /// Response is not successful
        default:
          final error = 'API -> getTopScorers -> StatusCode ${response.statusCode}';
          logger.e(error);

          return (playersResponse: null, error: error);
      }
    } catch (e) {
      final error = await handleCatch(
        methodName: 'getTopScorers',
        mainError: '$e',
      );

      return (playersResponse: null, error: error);
    }
  }

  ///
  /// `/players/topassists`
  ///

  Future<({PlayersResponse? playersResponse, String? error})> getTopAssists({
    required int leagueId,
    required String season,
  }) async {
    try {
      final response = await dio.get(
        '/players/topassists',
        queryParameters: {
          'league': leagueId,
          'season': season,
        },
      );

      /// Handle status codes
      switch (response.statusCode) {
        /// Response is successful
        case 200:
        case 304:
          try {
            final parsedResponse = await computePlayers(response.data);
            return (playersResponse: parsedResponse, error: null);
          } catch (e) {
            final error = 'API -> getTopAssists -> parsing error -> $e';
            logger.e(error);

            return (playersResponse: null, error: error);
          }

        /// Response is not successful
        default:
          final error = 'API -> getTopAssists -> StatusCode ${response.statusCode}';
          logger.e(error);

          return (playersResponse: null, error: error);
      }
    } catch (e) {
      final error = await handleCatch(
        methodName: 'getTopAssists',
        mainError: '$e',
      );

      return (playersResponse: null, error: error);
    }
  }

  ///
  /// `/players/topyellowcards`
  ///

  Future<({PlayersResponse? playersResponse, String? error})> getTopYellowCards({
    required int leagueId,
    required String season,
  }) async {
    try {
      final response = await dio.get(
        '/players/topyellowcards',
        queryParameters: {
          'league': leagueId,
          'season': season,
        },
      );

      /// Handle status codes
      switch (response.statusCode) {
        /// Response is successful
        case 200:
        case 304:
          try {
            final parsedResponse = await computePlayers(response.data);
            return (playersResponse: parsedResponse, error: null);
          } catch (e) {
            final error = 'API -> getTopYellowCards -> parsing error -> $e';
            logger.e(error);

            return (playersResponse: null, error: error);
          }

        /// Response is not successful
        default:
          final error = 'API -> getTopYellowCards -> StatusCode ${response.statusCode}';
          logger.e(error);

          return (playersResponse: null, error: error);
      }
    } catch (e) {
      final error = await handleCatch(
        methodName: 'getTopYellowCards',
        mainError: '$e',
      );

      return (playersResponse: null, error: error);
    }
  }

  ///
  /// `/players/topredcards`
  ///

  Future<({PlayersResponse? playersResponse, String? error})> getTopRedCards({
    required int leagueId,
    required String season,
  }) async {
    try {
      final response = await dio.get(
        '/players/topredcards',
        queryParameters: {
          'league': leagueId,
          'season': season,
        },
      );

      /// Handle status codes
      switch (response.statusCode) {
        /// Response is successful
        case 200:
        case 304:
          try {
            final parsedResponse = await computePlayers(response.data);
            return (playersResponse: parsedResponse, error: null);
          } catch (e) {
            final error = 'API -> getTopRedCards -> parsing error -> $e';
            logger.e(error);

            return (playersResponse: null, error: error);
          }

        /// Response is not successful
        default:
          final error = 'API -> getTopRedCards -> StatusCode ${response.statusCode}';
          logger.e(error);

          return (playersResponse: null, error: error);
      }
    } catch (e) {
      final error = await handleCatch(
        methodName: 'getTopRedCards',
        mainError: '$e',
      );

      return (playersResponse: null, error: error);
    }
  }

  ///
  /// `/coachs`
  ///

  Future<({CoachesResponse? coachesResponse, String? error})> getCoach({
    required int coachId,
  }) async {
    try {
      final response = await dio.get(
        '/coachs',
        queryParameters: {
          'id': coachId,
        },
      );

      /// Handle status codes
      switch (response.statusCode) {
        /// Response is successful
        case 200:
        case 304:
          try {
            final parsedResponse = await computeCoaches(response.data);
            return (coachesResponse: parsedResponse, error: null);
          } catch (e) {
            final error = 'API -> getCoach -> parsing error -> $e';
            logger.e(error);

            return (coachesResponse: null, error: error);
          }

        /// Response is not successful
        default:
          final error = 'API -> getCoach -> StatusCode ${response.statusCode}';
          logger.e(error);

          return (coachesResponse: null, error: error);
      }
    } catch (e) {
      final error = await handleCatch(
        methodName: 'getCoach',
        mainError: '$e',
      );

      return (coachesResponse: null, error: error);
    }
  }

  Future<({CoachesResponse? coachesResponse, String? error})> getCoachesFromTeam({
    required int teamId,
  }) async {
    try {
      final response = await dio.get(
        '/coachs',
        queryParameters: {
          'team': teamId,
        },
      );

      /// Handle status codes
      switch (response.statusCode) {
        /// Response is successful
        case 200:
        case 304:
          try {
            final parsedResponse = await computeCoaches(response.data);
            return (coachesResponse: parsedResponse, error: null);
          } catch (e) {
            final error = 'API -> getCoachesFromTeam -> parsing error -> $e';
            logger.e(error);

            return (coachesResponse: null, error: error);
          }

        /// Response is not successful
        default:
          final error = 'API -> getCoachesFromTeam -> StatusCode ${response.statusCode}';
          logger.e(error);

          return (coachesResponse: null, error: error);
      }
    } catch (e) {
      final error = await handleCatch(
        methodName: 'getCoachesFromTeam',
        mainError: '$e',
      );

      return (coachesResponse: null, error: error);
    }
  }

  ///
  /// `/transfers`
  ///

  Future<({TransfersResponse? transfersResponse, String? error})> getTransfersFromTeam({
    required int teamId,
  }) async {
    try {
      final response = await dio.get(
        '/transfers',
        queryParameters: {
          'team': teamId,
        },
      );

      /// Handle status codes
      switch (response.statusCode) {
        /// Response is successful
        case 200:
        case 304:
          try {
            final parsedResponse = await computeTransfers(response.data);
            return (transfersResponse: parsedResponse, error: null);
          } catch (e) {
            final error = 'API -> getTransfersFromTeam -> parsing error -> $e';
            logger.e(error);

            return (transfersResponse: null, error: error);
          }

        /// Response is not successful
        default:
          final error = 'API -> getTransfersFromTeam -> StatusCode ${response.statusCode}';
          logger.e(error);

          return (transfersResponse: null, error: error);
      }
    } catch (e) {
      final error = await handleCatch(
        methodName: 'getTransfersFromTeam',
        mainError: '$e',
      );

      return (transfersResponse: null, error: error);
    }
  }

  Future<({TransfersResponse? transfersResponse, String? error})> getTransfersFromPlayer({
    required int playerId,
  }) async {
    try {
      final response = await dio.get(
        '/transfers',
        queryParameters: {
          'player': playerId,
        },
      );

      /// Handle status codes
      switch (response.statusCode) {
        /// Response is successful
        case 200:
        case 304:
          try {
            final parsedResponse = await computeTransfers(response.data);
            return (transfersResponse: parsedResponse, error: null);
          } catch (e) {
            final error = 'API -> getTransfersFromPlayer -> parsing error -> $e';
            logger.e(error);

            return (transfersResponse: null, error: error);
          }

        /// Response is not successful
        default:
          final error = 'API -> getTransfersFromPlayer -> StatusCode ${response.statusCode}';
          logger.e(error);

          return (transfersResponse: null, error: error);
      }
    } catch (e) {
      final error = await handleCatch(
        methodName: 'getTransfersFromPlayer',
        mainError: '$e',
      );

      return (transfersResponse: null, error: error);
    }
  }

  ///
  /// `/sidelined`
  ///

  Future<({SidelinedResponse? sidelinedResponse, String? error})> getSidelinedFromPlayer({
    required int playerId,
  }) async {
    try {
      final response = await dio.get(
        '/sidelined',
        queryParameters: {
          'player': playerId,
        },
      );

      /// Handle status codes
      switch (response.statusCode) {
        /// Response is successful
        case 200:
        case 304:
          try {
            final parsedResponse = await computeSidelined(response.data);
            return (sidelinedResponse: parsedResponse, error: null);
          } catch (e) {
            final error = 'API -> getSidelinedFromPlayer -> parsing error -> $e';
            logger.e(error);

            return (sidelinedResponse: null, error: error);
          }

        /// Response is not successful
        default:
          final error = 'API -> getSidelinedFromPlayer -> StatusCode ${response.statusCode}';
          logger.e(error);

          return (sidelinedResponse: null, error: error);
      }
    } catch (e) {
      final error = await handleCatch(
        methodName: 'getSidelinedFromPlayer',
        mainError: '$e',
      );

      return (sidelinedResponse: null, error: error);
    }
  }

  Future<({SidelinedResponse? sidelinedResponse, String? error})> getSidelinedFromCoach({
    required int coachId,
  }) async {
    try {
      final response = await dio.get(
        '/sidelined',
        queryParameters: {
          'coach': coachId,
        },
      );

      /// Handle status codes
      switch (response.statusCode) {
        /// Response is successful
        case 200:
        case 304:
          try {
            final parsedResponse = await computeSidelined(response.data);
            return (sidelinedResponse: parsedResponse, error: null);
          } catch (e) {
            final error = 'API -> getSidelinedFromCoach -> parsing error -> $e';
            logger.e(error);

            return (sidelinedResponse: null, error: error);
          }

        /// Response is not successful
        default:
          final error = 'API -> getSidelinedFromCoach -> StatusCode ${response.statusCode}';
          logger.e(error);

          return (sidelinedResponse: null, error: error);
      }
    } catch (e) {
      final error = await handleCatch(
        methodName: 'getSidelinedFromCoach',
        mainError: '$e',
      );

      return (sidelinedResponse: null, error: error);
    }
  }

  ///
  /// `/trophies`
  ///

  Future<({TrophiesResponse? trophiesResponse, String? error})> getTrophiesFromPlayer({
    required int playerId,
  }) async {
    try {
      final response = await dio.get(
        '/trophies',
        queryParameters: {
          'player': playerId,
        },
      );

      /// Handle status codes
      switch (response.statusCode) {
        /// Response is successful
        case 200:
        case 304:
          try {
            final parsedResponse = await computeTrophies(response.data);
            return (trophiesResponse: parsedResponse, error: null);
          } catch (e) {
            final error = 'API -> getTrophiesFromPlayer -> parsing error -> $e';
            logger.e(error);

            return (trophiesResponse: null, error: error);
          }

        /// Response is not successful
        default:
          final error = 'API -> getTrophiesFromPlayer -> StatusCode ${response.statusCode}';
          logger.e(error);

          return (trophiesResponse: null, error: error);
      }
    } catch (e) {
      final error = await handleCatch(
        methodName: 'getTrophiesFromPlayer',
        mainError: '$e',
      );

      return (trophiesResponse: null, error: error);
    }
  }

  Future<({TrophiesResponse? trophiesResponse, String? error})> getTrophiesFromCoach({
    required int coachId,
  }) async {
    try {
      final response = await dio.get(
        '/trophies',
        queryParameters: {
          'coach': coachId,
        },
      );

      /// Handle status codes
      switch (response.statusCode) {
        /// Response is successful
        case 200:
        case 304:
          try {
            final parsedResponse = await computeTrophies(response.data);
            return (trophiesResponse: parsedResponse, error: null);
          } catch (e) {
            final error = 'API -> getTrophiesFromCoach -> parsing error -> $e';
            logger.e(error);

            return (trophiesResponse: null, error: error);
          }

        /// Response is not successful
        default:
          final error = 'API -> getTrophiesFromCoach -> StatusCode ${response.statusCode}';
          logger.e(error);

          return (trophiesResponse: null, error: error);
      }
    } catch (e) {
      final error = await handleCatch(
        methodName: 'getTrophiesFromCoach',
        mainError: '$e',
      );

      return (trophiesResponse: null, error: error);
    }
  }

  ///
  /// `/search`
  ///

  Future<({SearchCountriesResponse? searchCountriesResponse, String? error})> searchCountries({
    required String searchValue,
  }) async {
    try {
      final response = await dio.get(
        '/countries',
        queryParameters: {
          'search': searchValue,
        },
      );

      /// Handle status codes
      switch (response.statusCode) {
        /// Response is successful
        case 200:
        case 304:
          try {
            final parsedResponse = await computeSearchCountries(response.data);
            return (searchCountriesResponse: parsedResponse, error: null);
          } catch (e) {
            final error = 'API -> searchCountries -> parsing error -> $e';
            logger.e(error);

            return (searchCountriesResponse: null, error: error);
          }

        /// Response is not successful
        default:
          final error = 'API -> searchCountries -> StatusCode ${response.statusCode}';
          logger.e(error);

          return (searchCountriesResponse: null, error: error);
      }
    } catch (e) {
      final error = await handleCatch(
        methodName: 'searchCountries',
        mainError: '$e',
      );

      return (searchCountriesResponse: null, error: error);
    }
  }

  Future<({SearchLeaguesResponse? searchLeaguesResponse, String? error})> searchLeagues({
    required String searchValue,
  }) async {
    try {
      final response = await dio.get(
        '/leagues',
        queryParameters: {
          'search': searchValue,
        },
      );

      /// Handle status codes
      switch (response.statusCode) {
        /// Response is successful
        case 200:
        case 304:
          try {
            final parsedResponse = await computeSearchLeagues(response.data);
            return (searchLeaguesResponse: parsedResponse, error: null);
          } catch (e) {
            final error = 'API -> searchLeagues -> parsing error -> $e';
            logger.e(error);

            return (searchLeaguesResponse: null, error: error);
          }

        /// Response is not successful
        default:
          final error = 'API -> searchLeagues -> StatusCode ${response.statusCode}';
          logger.e(error);

          return (searchLeaguesResponse: null, error: error);
      }
    } catch (e) {
      final error = await handleCatch(
        methodName: 'searchLeagues',
        mainError: '$e',
      );

      return (searchLeaguesResponse: null, error: error);
    }
  }

  Future<({SearchTeamsResponse? searchTeamsResponse, String? error})> searchTeams({
    required String searchValue,
  }) async {
    try {
      final response = await dio.get(
        '/teams',
        queryParameters: {
          'search': searchValue,
        },
      );

      /// Handle status codes
      switch (response.statusCode) {
        /// Response is successful
        case 200:
        case 304:
          try {
            final parsedResponse = await computeSearchTeams(response.data);
            return (searchTeamsResponse: parsedResponse, error: null);
          } catch (e) {
            final error = 'API -> searchTeams -> parsing error -> $e';
            logger.e(error);

            return (searchTeamsResponse: null, error: error);
          }

        /// Response is not successful
        default:
          final error = 'API -> searchTeams -> StatusCode ${response.statusCode}';
          logger.e(error);

          return (searchTeamsResponse: null, error: error);
      }
    } catch (e) {
      final error = await handleCatch(
        methodName: 'searchTeams',
        mainError: '$e',
      );

      return (searchTeamsResponse: null, error: error);
    }
  }

  Future<({SearchPlayersResponse? searchPlayersResponse, String? error})> searchPlayers({
    required String searchValue,
  }) async {
    try {
      final response = await dio.get(
        '/players/profiles',
        queryParameters: {
          'search': searchValue,
        },
      );

      /// Handle status codes
      switch (response.statusCode) {
        /// Response is successful
        case 200:
        case 304:
          try {
            final parsedResponse = await computeSearchPlayers(response.data);
            return (searchPlayersResponse: parsedResponse, error: null);
          } catch (e) {
            final error = 'API -> searchPlayers -> parsing error -> $e';
            logger.e(error);

            return (searchPlayersResponse: null, error: error);
          }

        /// Response is not successful
        default:
          final error = 'API -> searchPlayers -> StatusCode ${response.statusCode}';
          logger.e(error);

          return (searchPlayersResponse: null, error: error);
      }
    } catch (e) {
      final error = await handleCatch(
        methodName: 'searchPlayers',
        mainError: '$e',
      );

      return (searchPlayersResponse: null, error: error);
    }
  }

  Future<({SearchCoachesResponse? searchCoachesResponse, String? error})> searchCoaches({
    required String searchValue,
  }) async {
    try {
      final response = await dio.get(
        '/coachs',
        queryParameters: {
          'search': searchValue,
        },
      );

      /// Handle status codes
      switch (response.statusCode) {
        /// Response is successful
        case 200:
        case 304:
          try {
            final parsedResponse = await computeSearchCoaches(response.data);
            return (searchCoachesResponse: parsedResponse, error: null);
          } catch (e) {
            final error = 'API -> searchCoaches -> parsing error -> $e';
            logger.e(error);

            return (searchCoachesResponse: null, error: error);
          }

        /// Response is not successful
        default:
          final error = 'API -> searchCoaches -> StatusCode ${response.statusCode}';
          logger.e(error);

          return (searchCoachesResponse: null, error: error);
      }
    } catch (e) {
      final error = await handleCatch(
        methodName: 'searchCoaches',
        mainError: '$e',
      );

      return (searchCoachesResponse: null, error: error);
    }
  }

  /// Checks for internet connection and returns error message
  Future<String> handleCatch({
    required String methodName,
    required String mainError,
  }) async {
    final hasInternet = await internetConnection.hasInternetAccess;
    final generatedError = hasInternet ? mainError : 'Internet connection error';
    final error = 'API -> $methodName -> catch -> $generatedError';
    logger.e(error);
    return error;
  }
}
