class PlayerStatisticPlayer {
  final int? id;
  final String? name;
  final String? photo;

  PlayerStatisticPlayer({
    this.id,
    this.name,
    this.photo,
  });

  factory PlayerStatisticPlayer.fromMap(Map<String, dynamic> map) => PlayerStatisticPlayer(
        id: map['id'] != null ? map['id'] as int : null,
        name: map['name'] != null ? map['name'] as String : null,
        photo: map['photo'] != null ? map['photo'] as String : null,
      );

  @override
  String toString() => 'PlayerStatisticPlayer(id: $id, name: $name, photo: $photo)';

  @override
  bool operator ==(covariant PlayerStatisticPlayer other) {
    if (identical(this, other)) {
      return true;
    }

    return other.id == id && other.name == name && other.photo == photo;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ photo.hashCode;
}
