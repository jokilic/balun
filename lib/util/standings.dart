import '../models/standings/league/league.dart';
import '../models/standings/standing/team_standing.dart';

List<TeamStanding>? getStandingsList({required League league}) => league.standings?.first
  ?..sort(
    (a, b) {
      final aRank = a.rank ?? 0;
      final bRank = b.rank ?? 0;

      return aRank.compareTo(bRank);
    },
  );
