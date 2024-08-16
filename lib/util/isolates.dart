import 'package:flutter/foundation.dart';

import '../models/coaches/coaches_response.dart';
import '../models/fixtures/fixtures_response.dart';
import '../models/leagues/leagues_response.dart';
import '../models/players/players_response.dart';
import '../models/squads/squads_response.dart';
import '../models/standings/standings_response.dart';
import '../models/teams/teams_response.dart';

Future<FixturesResponse> computeFixtures(data) async => compute(parseFixtures, data);
FixturesResponse parseFixtures(data) => FixturesResponse.fromMap(data);

Future<TeamsResponse> computeTeams(data) async => compute(parseTeams, data);
TeamsResponse parseTeams(data) => TeamsResponse.fromMap(data);

Future<StandingsResponse> computeStandings(data) async => compute(parseStandings, data);
StandingsResponse parseStandings(data) => StandingsResponse.fromMap(data);

Future<LeaguesResponse> computeLeagues(data) async => compute(parseLeagues, data);
LeaguesResponse parseLeagues(data) => LeaguesResponse.fromMap(data);

Future<PlayersResponse> computePlayers(data) async => compute(parsePlayers, data);
PlayersResponse parsePlayers(data) => PlayersResponse.fromMap(data);

Future<CoachesResponse> computeCoaches(data) async => compute(parseCoaches, data);
CoachesResponse parseCoaches(data) => CoachesResponse.fromMap(data);

Future<SquadsResponse> computeSquads(data) async => compute(parseSquads, data);
SquadsResponse parseSquads(data) => SquadsResponse.fromMap(data);
