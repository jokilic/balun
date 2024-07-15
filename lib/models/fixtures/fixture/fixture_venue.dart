class FixtureVenue {
  final int? id;
  final String? name;
  final String? city;

  FixtureVenue({
    this.id,
    this.name,
    this.city,
  });

  factory FixtureVenue.fromMap(Map<String, dynamic> map) => FixtureVenue(
        id: map['id'] != null ? map['id'] as int : null,
        name: map['name'] != null ? map['name'] as String : null,
        city: map['city'] != null ? map['city'] as String : null,
      );

  @override
  String toString() => 'FixtureVenue(id: $id, name: $name, city: $city)';

  @override
  bool operator ==(covariant FixtureVenue other) {
    if (identical(this, other)) {
      return true;
    }

    return other.id == id && other.name == name && other.city == city;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ city.hashCode;
}
