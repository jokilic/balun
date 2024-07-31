class PlayerStatisticInnerDribbles {
  final int? attempts;
  final int? success;
  final int? past;

  PlayerStatisticInnerDribbles({
    this.attempts,
    this.success,
    this.past,
  });

  factory PlayerStatisticInnerDribbles.fromMap(Map<String, dynamic> map) => PlayerStatisticInnerDribbles(
        attempts: map['attempts'] != null ? map['attempts'] as int : null,
        success: map['success'] != null ? map['success'] as int : null,
        past: map['past'] != null ? map['past'] as int : null,
      );

  @override
  String toString() => 'PlayerStatisticInnerDribbles(attempts: $attempts, success: $success, past: $past)';

  @override
  bool operator ==(covariant PlayerStatisticInnerDribbles other) {
    if (identical(this, other)) {
      return true;
    }

    return other.attempts == attempts && other.success == success && other.past == past;
  }

  @override
  int get hashCode => attempts.hashCode ^ success.hashCode ^ past.hashCode;
}
