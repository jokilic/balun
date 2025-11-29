import 'package:hive_ce/hive.dart';

part 'favorite_match.g.dart';

@HiveType(typeId: 6)
class FavoriteMatch {
  @HiveField(0)
  final int? matchId;
  @HiveField(1)
  final DateTime? matchDate;
  @HiveField(2)
  final int? leagueId;
  @HiveField(3)
  final String? leagueName;
  @HiveField(4)
  final String? leagueLogo;
  @HiveField(5)
  final int? homeTeamId;
  @HiveField(6)
  final String? homeTeamName;
  @HiveField(7)
  final String? homeTeamLogo;
  @HiveField(8)
  final int? awayTeamId;
  @HiveField(9)
  final String? awayTeamName;
  @HiveField(10)
  final String? awayTeamLogo;

  FavoriteMatch({
    this.matchId,
    this.matchDate,
    this.leagueId,
    this.leagueName,
    this.leagueLogo,
    this.homeTeamId,
    this.homeTeamName,
    this.homeTeamLogo,
    this.awayTeamId,
    this.awayTeamName,
    this.awayTeamLogo,
  });

  @override
  String toString() =>
      'FavoriteMatch(matchId: $matchId, matchDate: $matchDate, leagueId: $leagueId, leagueName: $leagueName, leagueLogo: $leagueLogo, homeTeamId: $homeTeamId, homeTeamName: $homeTeamName, homeTeamLogo: $homeTeamLogo, awayTeamId: $awayTeamId, awayTeamName: $awayTeamName, awayTeamLogo: $awayTeamLogo)';

  @override
  bool operator ==(covariant FavoriteMatch other) {
    if (identical(this, other)) {
      return true;
    }

    return other.matchId == matchId &&
        other.matchDate == matchDate &&
        other.leagueId == leagueId &&
        other.leagueName == leagueName &&
        other.leagueLogo == leagueLogo &&
        other.homeTeamId == homeTeamId &&
        other.homeTeamName == homeTeamName &&
        other.homeTeamLogo == homeTeamLogo &&
        other.awayTeamId == awayTeamId &&
        other.awayTeamId == awayTeamId &&
        other.awayTeamId == awayTeamId;
  }

  @override
  int get hashCode =>
      matchId.hashCode ^
      matchDate.hashCode ^
      leagueId.hashCode ^
      leagueName.hashCode ^
      leagueLogo.hashCode ^
      homeTeamId.hashCode ^
      homeTeamName.hashCode ^
      homeTeamLogo.hashCode ^
      awayTeamId.hashCode ^
      awayTeamName.hashCode ^
      awayTeamLogo.hashCode;
}
