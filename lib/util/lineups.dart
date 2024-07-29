import '../models/fixtures/lineup/lineup.dart';

List<int>? parseFormation(Lineup? lineup) {
  if (lineup?.formation != null) {
    return [1] + lineup!.formation!.split('-').map(int.parse).toList();
  }
  return null;
}

List<double> calculateRowSpacings(int totalRows) {
  /// Assign weights to spaces between rows
  /// More weight means more space
  final weights = [1.25]; // Space before first row (goalkeeper)

  for (var i = 1; i < totalRows; i++) {
    weights
      ..add(2) // Space for player row
      ..add(2); // Space between rows
  }

  weights
    ..add(2) // Space for last player row
    ..add(2); // Space after last row

  final totalWeight = weights.reduce((a, b) => a + b);

  return weights.map((w) => w / totalWeight).toList();
}

double calculateYPosition(int row, List<double> spacings) {
  var position = 0.0;

  for (var i = 0; i < (row * 2) - 1; i++) {
    position += spacings[i];
  }

  return position;
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
