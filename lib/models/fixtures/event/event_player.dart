class EventPlayer {
  final int? id;
  final String? name;

  EventPlayer({
    this.id,
    this.name,
  });

  factory EventPlayer.fromMap(Map<String, dynamic> map) => EventPlayer(
        id: map['id'] != null ? map['id'] as int : null,
        name: map['name'] != null ? map['name'] as String : null,
      );

  @override
  String toString() => 'EventPlayer(id: $id, name: $name)';

  @override
  bool operator ==(covariant EventPlayer other) {
    if (identical(this, other)) {
      return true;
    }

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
