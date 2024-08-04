import 'season_coverage_fixtures.dart';

class SeasonCoverage {
  final SeasonCoverageFixtures? fixtures;
  final bool? standings;
  final bool? players;
  final bool? topScorers;
  final bool? topAssists;
  final bool? topCards;
  final bool? injuries;
  final bool? predictions;
  final bool? odds;

  SeasonCoverage({
    this.fixtures,
    this.standings,
    this.players,
    this.topScorers,
    this.topAssists,
    this.topCards,
    this.injuries,
    this.predictions,
    this.odds,
  });

  factory SeasonCoverage.fromMap(Map<String, dynamic> map) => SeasonCoverage(
        fixtures: map['fixtures'] != null ? SeasonCoverageFixtures.fromMap(map['fixtures'] as Map<String, dynamic>) : null,
        standings: map['standings'] != null ? map['standings'] as bool : null,
        players: map['players'] != null ? map['players'] as bool : null,
        topScorers: map['top_scorers'] != null ? map['top_scorers'] as bool : null,
        topAssists: map['top_assists'] != null ? map['top_assists'] as bool : null,
        topCards: map['top_cards'] != null ? map['top_cards'] as bool : null,
        injuries: map['injuries'] != null ? map['injuries'] as bool : null,
        predictions: map['predictions'] != null ? map['predictions'] as bool : null,
        odds: map['odds'] != null ? map['odds'] as bool : null,
      );

  @override
  String toString() =>
      'SeasonCoverage(fixtures: $fixtures, standings: $standings, players: $players, topScorers: $topScorers, topAssists: $topAssists, topCards: $topCards, injuries: $injuries, predictions: $predictions, odds: $odds)';

  @override
  bool operator ==(covariant SeasonCoverage other) {
    if (identical(this, other)) {
      return true;
    }

    return other.fixtures == fixtures &&
        other.standings == standings &&
        other.players == players &&
        other.topScorers == topScorers &&
        other.topAssists == topAssists &&
        other.topCards == topCards &&
        other.injuries == injuries &&
        other.predictions == predictions &&
        other.odds == odds;
  }

  @override
  int get hashCode =>
      fixtures.hashCode ^
      standings.hashCode ^
      players.hashCode ^
      topScorers.hashCode ^
      topAssists.hashCode ^
      topCards.hashCode ^
      injuries.hashCode ^
      predictions.hashCode ^
      odds.hashCode;
}
