class Team {
  final int? id;
  final String? name;
  final String? logo;
  final bool? winner;

  Team({
    this.id,
    this.name,
    this.logo,
    this.winner,
  });

  factory Team.fromMap(Map<String, dynamic> map) => Team(
        id: map['id'] != null ? map['id'] as int : null,
        name: map['name'] != null ? map['name'] as String : null,
        logo: map['logo'] != null ? map['logo'] as String : null,
        winner: map['winner'] != null ? map['winner'] as bool : null,
      );

  @override
  String toString() => 'Team(id: $id, name: $name, logo: $logo, winner: $winner)';

  @override
  bool operator ==(covariant Team other) {
    if (identical(this, other)) {
      return true;
    }

    return other.id == id && other.name == name && other.logo == logo && other.winner == winner;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ logo.hashCode ^ winner.hashCode;
}
