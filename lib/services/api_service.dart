import 'package:dio/dio.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../models/coaches/coaches_response.dart';
import '../models/fixtures/fixtures_response.dart';
import '../models/leagues/leagues_response.dart';
import '../models/players/players_response.dart';
import '../models/squads/squads_response.dart';
import '../models/standings/standings_response.dart';
import '../models/teams/teams_response.dart';
import '../models/transfers/transfers_response.dart';
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
  /// `/fixtures`
  ///

  Future<({FixturesResponse? fixturesResponse, String? error})> getFixtures() async {
    try {
      final response = await dio.get(
        '/fixtures',
        queryParameters: {
          // TODO: Implement this properly
          // 'live': 'all',
          'last': 15,
        },
      );

      /// Handle status codes
      switch (response.statusCode) {
        /// Response is successful
        case 200:
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
    required int season,
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
    required int season,
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
    required int season,
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
    required int season,
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
    required int season,
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
    required int season,
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
    required int season,
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
    required int season,
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
