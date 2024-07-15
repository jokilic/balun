import 'lineup_colors.dart';

class LineupTeam {
  final int? id;
  final String? name;
  final String? logo;
  final LineupColors? colors;

  LineupTeam({
    this.id,
    this.name,
    this.logo,
    this.colors,
  });

  factory LineupTeam.fromMap(Map<String, dynamic> map) => LineupTeam(
        id: map['id'] != null ? map['id'] as int : null,
        name: map['name'] != null ? map['name'] as String : null,
        logo: map['logo'] != null ? map['logo'] as String : null,
        colors: map['colors'] != null ? LineupColors.fromMap(map['colors'] as Map<String, dynamic>) : null,
      );

  @override
  String toString() => 'LineupTeam(id: $id, name: $name, logo: $logo, colors: $colors)';

  @override
  bool operator ==(covariant LineupTeam other) {
    if (identical(this, other)) {
      return true;
    }

    return other.id == id && other.name == name && other.logo == logo && other.colors == colors;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ logo.hashCode ^ colors.hashCode;
}
