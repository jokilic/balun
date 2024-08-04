class League {
  final int? id;
  final String? name;
  final String? type;
  final String? logo;

  League({
    this.id,
    this.name,
    this.type,
    this.logo,
  });

  factory League.fromMap(Map<String, dynamic> map) => League(
        id: map['id'] != null ? map['id'] as int : null,
        name: map['name'] != null ? map['name'] as String : null,
        type: map['type'] != null ? map['type'] as String : null,
        logo: map['logo'] != null ? map['logo'] as String : null,
      );

  @override
  String toString() => 'League(id: $id, name: $name, type: $type, logo: $logo)';

  @override
  bool operator ==(covariant League other) {
    if (identical(this, other)) {
      return true;
    }

    return other.id == id && other.name == name && other.type == type && other.logo == logo;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ type.hashCode ^ logo.hashCode;
}
