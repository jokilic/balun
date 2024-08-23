import 'package:dio/dio.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../models/coaches/coaches_response.dart';
import '../models/countries/countries_response.dart';
import '../models/fixtures/fixtures_response.dart';
import '../models/leagues/leagues_response.dart';
import '../models/players/players_response.dart';
import '../models/sidelined/sidelined_response.dart';
import '../models/squads/squads_response.dart';
import '../models/standings/standings_response.dart';
import '../models/teams/teams_response.dart';
import '../models/transfers/transfers_response.dart';
import '../models/trophies/trophies_response.dart';
import '../util/isolates.dart';
import 'logger_service.dart';

class APIService {
  final LoggerService logger;
  final Dio noCacheDio;
  final Dio cacheDio;
  final InternetConnection internetConnection;

  APIService({
    required this.logger,
    required this.noCacheDio,
    required this.cacheDio,
    required this.internetConnection,
  });

  ///
  /// `/countries`
  ///

  Future<({CountriesResponse? countriesResponse, String? error})> getCountries() async {
    try {
      final response = await cacheDio.get(
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
      final response = await noCacheDio.get(
        '/fixtures',
        queryParameters: {
          // 'date': dateString,
          // TODO: Remove this below and potentially filter by leagues
          // 'next': 5,
          'last': 5,
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
    required int season,
  }) async {
    try {
      final response = await cacheDio.get(
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

  Future<({FixturesResponse? fixturesResponse, String? error})> getMatch({
    required int matchId,
  }) async {
    try {
      final response = await noCacheDio.get(
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
      final response = await cacheDio.get(
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
      final response = await cacheDio.get(
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
    required int season,
  }) async {
    try {
      final response = await cacheDio.get(
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
    required int season,
  }) async {
    try {
      final response = await cacheDio.get(
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
    required int season,
  }) async {
    try {
      final response = await cacheDio.get(
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
      final response = await cacheDio.get(
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
      final response = await cacheDio.get(
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
      final response = await cacheDio.get(
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
    required int season,
  }) async {
    try {
      final response = await cacheDio.get(
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
  /// `/players/squads`
  ///

  Future<({SquadsResponse? squadsResponse, String? error})> getPlayersFromTeam({
    required int teamId,
  }) async {
    try {
      final response = await cacheDio.get(
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
    required int season,
  }) async {
    try {
      final response = await cacheDio.get(
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
    required int season,
  }) async {
    try {
      final response = await cacheDio.get(
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
    required int season,
  }) async {
    try {
      final response = await cacheDio.get(
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
    required int season,
  }) async {
    try {
      final response = await cacheDio.get(
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

  Future<({CoachesResponse? coachesResponse, String? error})> getCoachesFromTeam({
    required int teamId,
  }) async {
    try {
      final response = await cacheDio.get(
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
      final response = await cacheDio.get(
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
      final response = await cacheDio.get(
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
      final response = await cacheDio.get(
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

  ///
  /// `/trophies`
  ///

  Future<({TrophiesResponse? trophiesResponse, String? error})> getTrophiesFromPlayer({
    required int playerId,
  }) async {
    try {
      final response = await cacheDio.get(
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
