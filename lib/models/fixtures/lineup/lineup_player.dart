class LineupPlayer {
  final LineupPlayerInside? player;

  LineupPlayer({
    this.player,
  });

  factory LineupPlayer.fromMap(Map<String, dynamic> map) => LineupPlayer(
        player: map['player'] != null ? LineupPlayerInside.fromMap(map['player'] as Map<String, dynamic>) : null,
      );

  @override
  String toString() => 'LineupPlayer(player: $player)';

  @override
  bool operator ==(covariant LineupPlayer other) {
    if (identical(this, other)) {
      return true;
    }

    return other.player == player;
  }

  @override
  int get hashCode => player.hashCode;
}

class LineupPlayerInside {
  final int? id;
  final String? name;
  final int? number;
  final String? pos;
  final String? grid;

  LineupPlayerInside({
    this.id,
    this.name,
    this.number,
    this.pos,
    this.grid,
  });

  factory LineupPlayerInside.fromMap(Map<String, dynamic> map) => LineupPlayerInside(
        id: map['id'] != null ? map['id'] as int : null,
        name: map['name'] != null ? map['name'] as String : null,
        number: map['number'] != null ? map['number'] as int : null,
        pos: map['pos'] != null ? map['pos'] as String : null,
        grid: map['grid'] != null ? map['grid'] as String : null,
      );

  @override
  String toString() => 'LineupPlayerInside(id: $id, name: $name, number: $number, pos: $pos, grid: $grid)';

  @override
  bool operator ==(covariant LineupPlayerInside other) {
    if (identical(this, other)) {
      return true;
    }

    return other.id == id && other.name == name && other.number == number && other.pos == pos && other.grid == grid;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ number.hashCode ^ pos.hashCode ^ grid.hashCode;
}
