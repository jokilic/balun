class LineupCoach {
  final int? id;
  final String? name;

  LineupCoach({
    this.id,
    this.name,
  });

  factory LineupCoach.fromMap(Map<String, dynamic> map) => LineupCoach(
        id: map['id'] != null ? map['id'] as int : null,
        name: map['name'] != null ? map['name'] as String : null,
      );

  @override
  String toString() => 'LineupCoach(id: $id, name: $name)';

  @override
  bool operator ==(covariant LineupCoach other) {
    if (identical(this, other)) {
      return true;
    }

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
