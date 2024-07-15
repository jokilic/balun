class StatisticTeam {
  final int? id;
  final String? name;
  final String? logo;

  StatisticTeam({
    this.id,
    this.name,
    this.logo,
  });

  factory StatisticTeam.fromMap(Map<String, dynamic> map) => StatisticTeam(
        id: map['id'] != null ? map['id'] as int : null,
        name: map['name'] != null ? map['name'] as String : null,
        logo: map['logo'] != null ? map['logo'] as String : null,
      );

  @override
  String toString() => 'StatisticTeam(id: $id, name: $name, logo: $logo)';

  @override
  bool operator ==(covariant StatisticTeam other) {
    if (identical(this, other)) {
      return true;
    }

    return other.id == id && other.name == name && other.logo == logo;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ logo.hashCode;
}
