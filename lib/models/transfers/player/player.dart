class Player {
  final int? id;
  final String? name;

  Player({
    this.id,
    this.name,
  });

  factory Player.fromMap(Map<String, dynamic> map) => Player(
        id: map['id'] != null ? map['id'] as int : null,
        name: map['name'] != null ? map['name'] as String : null,
      );

  @override
  String toString() => 'Player(id: $id, name: $name)';

  @override
  bool operator ==(covariant Player other) {
    if (identical(this, other)) {
      return true;
    }

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
