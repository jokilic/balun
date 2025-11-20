import 'package:flutter/foundation.dart';

import '../models/coaches/coaches_response.dart';
import '../models/countries/countries_response.dart';
import '../models/fixtures/fixtures_response.dart';
import '../models/leagues/leagues_response.dart';
import '../models/news/news_response.dart';
import '../models/player_teams/player_teams_response.dart';
import '../models/players/players_response.dart';
import '../models/remote_settings/remote_settings_response.dart';
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
import '../models/youtube_search/youtube_search_response.dart';

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

Future<PlayerTeamsResponse> computePlayerTeams(data) async => compute(parsePlayerTeams, data);
PlayerTeamsResponse parsePlayerTeams(data) => PlayerTeamsResponse.fromMap(data);

Future<CoachesResponse> computeCoaches(data) async => compute(parseCoaches, data);
CoachesResponse parseCoaches(data) => CoachesResponse.fromMap(data);

Future<SquadsResponse> computeSquads(data) async => compute(parseSquads, data);
SquadsResponse parseSquads(data) => SquadsResponse.fromMap(data);

Future<TransfersResponse> computeTransfers(data) async => compute(parseTransfers, data);
TransfersResponse parseTransfers(data) => TransfersResponse.fromMap(data);

Future<SidelinedResponse> computeSidelined(data) async => compute(parseSidelined, data);
SidelinedResponse parseSidelined(data) => SidelinedResponse.fromMap(data);

Future<TrophiesResponse> computeTrophies(data) async => compute(parseTrophies, data);
TrophiesResponse parseTrophies(data) => TrophiesResponse.fromMap(data);

Future<CountriesResponse> computeCountries(data) async => compute(parseCountries, data);
CountriesResponse parseCountries(data) => CountriesResponse.fromMap(data);

Future<SearchCountriesResponse> computeSearchCountries(data) async => compute(parseSearchCountries, data);
SearchCountriesResponse parseSearchCountries(data) => SearchCountriesResponse.fromMap(data);

Future<SearchLeaguesResponse> computeSearchLeagues(data) async => compute(parseSearchLeagues, data);
SearchLeaguesResponse parseSearchLeagues(data) => SearchLeaguesResponse.fromMap(data);

Future<SearchTeamsResponse> computeSearchTeams(data) async => compute(parseSearchTeams, data);
SearchTeamsResponse parseSearchTeams(data) => SearchTeamsResponse.fromMap(data);

Future<SearchPlayersResponse> computeSearchPlayers(data) async => compute(parseSearchPlayers, data);
SearchPlayersResponse parseSearchPlayers(data) => SearchPlayersResponse.fromMap(data);

Future<SearchCoachesResponse> computeSearchCoaches(data) async => compute(parseSearchCoaches, data);
SearchCoachesResponse parseSearchCoaches(data) => SearchCoachesResponse.fromMap(data);

Future<RemoteSettingsResponse> computeRemoteSettings(data) async => compute(parseRemoteSettings, data);
RemoteSettingsResponse parseRemoteSettings(data) => RemoteSettingsResponse.fromMap(data);

Future<YouTubeSearchResponse> computeYouTubeSearch(data) async => compute(parseYouTubeSearch, data);
YouTubeSearchResponse parseYouTubeSearch(data) => YouTubeSearchResponse.fromMap(data);

Future<NewsResponse> computeNews(data) async => compute(parseNews, data);
NewsResponse parseNews(data) => NewsResponse.fromMap(data);

Future<StatusResponse> computeStatus(data) async => compute(parseStatus, data);
StatusResponse parseStatus(data) => StatusResponse.fromMap(data);
