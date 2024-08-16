class PlayerStatisticTeam {
  final int? id;
  final String? name;
  final String? logo;
  final DateTime? update;

  PlayerStatisticTeam({
    this.id,
    this.name,
    this.logo,
    this.update,
  });

  factory PlayerStatisticTeam.fromMap(Map<String, dynamic> map) => PlayerStatisticTeam(
        id: map['id'] != null ? map['id'] as int : null,
        name: map['name'] != null ? map['name'] as String : null,
        logo: map['logo'] != null ? map['logo'] as String : null,
        update: map['date'] != null ? DateTime.tryParse(map['date'] as String) : null,
      );

  @override
  String toString() => 'StatisticTeam(id: $id, name: $name, logo: $logo, update: $update)';

  @override
  bool operator ==(covariant PlayerStatisticTeam other) {
    if (identical(this, other)) {
      return true;
    }

    return other.id == id && other.name == name && other.logo == logo && other.update == update;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ logo.hashCode ^ update.hashCode;
}
