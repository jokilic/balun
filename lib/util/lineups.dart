import '../models/fixtures/lineup/lineup.dart';
import '../models/fixtures/lineup/lineup_player.dart';
import '../models/fixtures/player_statistic/player_statistic.dart';

double? calculateAverageRating({
  required PlayerStatistic? playerStatistic,
}) {
  if (playerStatistic == null) {
    return null;
  }

  var totalRating = 0.0;
  var ratingCount = 0;

  if (playerStatistic.statistics?.isNotEmpty ?? false) {
    for (final playerData in playerStatistic.statistics!) {
      if (playerData.statistic?.isNotEmpty ?? false) {
        for (final inner in playerData.statistic!) {
          if (inner.games?.rating != null) {
            totalRating += inner.games!.rating!;
            ratingCount++;
          }
        }
      }
    }
  }

  return ratingCount > 0 ? totalRating / ratingCount : null;
}

List<int>? parseFormation(Lineup? lineup) {
  if (lineup?.formation != null) {
    return [1] + lineup!.formation!.split('-').map(int.parse).toList();
  }
  return null;
}

List<double> calculateRowSpacings(int totalRows, bool isHome) {
  /// Assign weights to spaces between rows
  /// More weight means more space
  final weights = [if (isHome) 2 else 4]; // Slightly increased space before first row (goalkeeper)

  for (var i = 1; i < totalRows - 1; i++) {
    weights
      ..add(2) // Space for player row
      ..add(4 + i); // Further increased space between rows
  }

  weights
    ..add(2) // Space for last player row
    ..add(4); // Increased space after last row (before center)

  final totalWeight = weights.reduce((a, b) => a + b);

  return weights.map((w) => w / totalWeight).toList();
}

double calculateYPosition(int row, List<double> spacings, bool isHome) {
  var position = 0.0;

  for (var i = 0; i < (row * 2) - 1; i++) {
    position += spacings[i];
  }

  /// Adjust position based on whether it's home or away team
  if (isHome) {
    /// Move home team players slightly towards center
    return position * 0.9;
  } else {
    /// Move away team players slightly towards center
    return 1 - (position * 0.9);
  }
}

double calculateXPosition(int positionInRow, int playersInRow) {
  /// Define the usable width of the field (leaving some space on the sides)
  const usableWidthFraction = 1.25;

  /// Calculate the spacing between players based on the number of players in the row
  final spacing = usableWidthFraction / (playersInRow + 1);

  /// Calculate the starting point for the first player
  const startPoint = (1 - usableWidthFraction) / 2;

  /// Calculate the x position
  return startPoint + (positionInRow * spacing);
}

List<LineupPlayer>? sortPlayersByPosition(List<LineupPlayer>? players) {
  final posOrder = {
    'G': 0,
    'D': 1,
    'M': 2,
    'F': 3,
  };

  players?.sort(
    (a, b) {
      final playerA = a.player;
      final playerB = b.player;

      /// First, compare by `pos`
      final posComparison = posOrder[playerA?.pos]?.compareTo(
        posOrder[playerB?.pos] ?? 0,
      );

      /// If positions are the same, compare by `number`
      if (posComparison == 0) {
        return playerA?.number?.compareTo(playerB?.number ?? 0) ?? 0;
      }

      return posComparison ?? 0;
    },
  );

  return players;
}
