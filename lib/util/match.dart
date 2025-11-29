import '../models/fixtures/fixture_response.dart';
import '../models/matches/favorite_match.dart';

FavoriteMatch getFavoriteMatch({required FixtureResponse match}) => FavoriteMatch(
  matchId: match.fixture?.id,
  matchDate: match.fixture?.date,
  leagueId: match.league?.id,
  leagueName: match.league?.name,
  leagueLogo: match.league?.logo,
  homeTeamId: match.teams?.home?.id,
  homeTeamName: match.teams?.home?.name,
  homeTeamLogo: match.teams?.home?.logo,
  awayTeamId: match.teams?.away?.id,
  awayTeamName: match.teams?.away?.name,
  awayTeamLogo: match.teams?.away?.logo,
);
