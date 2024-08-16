class Player {
  final int? id;
  final String? name;
  final int? age;
  final int? number;
  final String? position;
  final String? photo;

  Player({
    this.id,
    this.name,
    this.age,
    this.number,
    this.position,
    this.photo,
  });

  factory Player.fromMap(Map<String, dynamic> map) => Player(
        id: map['id'] != null ? map['id'] as int : null,
        name: map['name'] != null ? map['name'] as String : null,
        age: map['age'] != null ? map['age'] as int : null,
        number: map['number'] != null ? map['number'] as int : null,
        position: map['position'] != null ? map['position'] as String : null,
        photo: map['photo'] != null ? map['photo'] as String : null,
      );

  @override
  String toString() => 'Player(id: $id, name: $name, age: $age, number: $number, position: $position, photo: $photo)';

  @override
  bool operator ==(covariant Player other) {
    if (identical(this, other)) {
      return true;
    }

    return other.id == id && other.name == name && other.age == age && other.number == number && other.position == position && other.photo == photo;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ age.hashCode ^ number.hashCode ^ position.hashCode ^ photo.hashCode;
}
