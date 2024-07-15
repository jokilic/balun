import 'lineup_color.dart';

class LineupColors {
  final LineupColor? player;
  final LineupColor? goalkeeper;

  LineupColors({
    this.player,
    this.goalkeeper,
  });

  factory LineupColors.fromMap(Map<String, dynamic> map) => LineupColors(
        player: map['player'] != null ? LineupColor.fromMap(map['player'] as Map<String, dynamic>) : null,
        goalkeeper: map['goalkeeper'] != null ? LineupColor.fromMap(map['goalkeeper'] as Map<String, dynamic>) : null,
      );

  @override
  String toString() => 'LineupColors(player: $player, goalkeeper: $goalkeeper)';

  @override
  bool operator ==(covariant LineupColors other) {
    if (identical(this, other)) {
      return true;
    }

    return other.player == player && other.goalkeeper == goalkeeper;
  }

  @override
  int get hashCode => player.hashCode ^ goalkeeper.hashCode;
}
