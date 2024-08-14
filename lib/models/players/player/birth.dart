class Birth {
  final DateTime? date;
  final String? place;
  final String? country;

  Birth({
    this.date,
    this.place,
    this.country,
  });

  factory Birth.fromMap(Map<String, dynamic> map) => Birth(
        date: map['date'] != null ? DateTime.parse(map['date'] as String) : null,
        place: map['place'] != null ? map['place'] as String : null,
        country: map['country'] != null ? map['country'] as String : null,
      );

  @override
  String toString() => 'Birth(date: $date, place: $place, country: $country)';

  @override
  bool operator ==(covariant Birth other) {
    if (identical(this, other)) {
      return true;
    }

    return other.date == date && other.place == place && other.country == country;
  }

  @override
  int get hashCode => date.hashCode ^ place.hashCode ^ country.hashCode;
}
