class PlayerStatisticInnerGames {
  final int? minutes;
  final int? number;
  final String? position;
  final double? rating;
  final bool? captain;
  final bool? substitute;

  PlayerStatisticInnerGames({
    this.minutes,
    this.number,
    this.position,
    this.rating,
    this.captain,
    this.substitute,
  });

  factory PlayerStatisticInnerGames.fromMap(Map<String, dynamic> map) => PlayerStatisticInnerGames(
        minutes: map['minutes'] != null ? map['minutes'] as int : null,
        number: map['number'] != null ? map['number'] as int : null,
        position: map['position'] != null ? map['position'] as String : null,
        rating: map['rating'] != null ? double.tryParse(map['rating'] as String) : null,
        captain: map['captain'] != null ? map['captain'] as bool : null,
        substitute: map['substitute'] != null ? map['substitute'] as bool : null,
      );

  @override
  String toString() => 'PlayerStatisticInnerGames(minutes: $minutes, number: $number, position: $position, rating: $rating, captain: $captain, substitute: $substitute)';

  @override
  bool operator ==(covariant PlayerStatisticInnerGames other) {
    if (identical(this, other)) {
      return true;
    }

    return other.minutes == minutes && other.number == number && other.position == position && other.rating == rating && other.captain == captain && other.substitute == substitute;
  }

  @override
  int get hashCode => minutes.hashCode ^ number.hashCode ^ position.hashCode ^ rating.hashCode ^ captain.hashCode ^ substitute.hashCode;
}
