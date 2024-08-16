class StatisticGames {
  final int? appearences;
  final int? lineups;
  final int? minutes;
  final int? number;
  final String? position;
  final double? rating;
  final bool? captain;

  StatisticGames({
    this.appearences,
    this.lineups,
    this.minutes,
    this.number,
    this.position,
    this.rating,
    this.captain,
  });

  factory StatisticGames.fromMap(Map<String, dynamic> map) => StatisticGames(
        appearences: map['appearences'] != null ? map['appearences'] as int : null,
        lineups: map['lineups'] != null ? map['lineups'] as int : null,
        minutes: map['minutes'] != null ? map['minutes'] as int : null,
        number: map['number'] != null ? map['number'] as int : null,
        position: map['position'] != null ? map['position'] as String : null,
        rating: map['rating'] != null ? double.tryParse(map['rating'] as String) : null,
        captain: map['captain'] != null ? map['captain'] as bool : null,
      );

  @override
  String toString() => 'StatisticGames(appearences: $appearences, lineups: $lineups, minutes: $minutes, number: $number, position: $position, rating: $rating, captain: $captain)';

  @override
  bool operator ==(covariant StatisticGames other) {
    if (identical(this, other)) {
      return true;
    }

    return other.appearences == appearences &&
        other.lineups == lineups &&
        other.minutes == minutes &&
        other.number == number &&
        other.position == position &&
        other.rating == rating &&
        other.captain == captain;
  }

  @override
  int get hashCode => appearences.hashCode ^ lineups.hashCode ^ minutes.hashCode ^ number.hashCode ^ position.hashCode ^ rating.hashCode ^ captain.hashCode;
}
