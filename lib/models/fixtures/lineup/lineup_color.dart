class LineupColor {
  final String? primary;
  final String? number;
  final String? border;

  LineupColor({
    this.primary,
    this.number,
    this.border,
  });

  factory LineupColor.fromMap(Map<String, dynamic> map) => LineupColor(
        primary: map['primary'] != null ? map['primary'] as String : null,
        number: map['number'] != null ? map['number'] as String : null,
        border: map['border'] != null ? map['border'] as String : null,
      );

  @override
  String toString() => 'LineupColor(primary: $primary, number: $number, border: $border)';

  @override
  bool operator ==(covariant LineupColor other) {
    if (identical(this, other)) {
      return true;
    }

    return other.primary == primary && other.number == number && other.border == border;
  }

  @override
  int get hashCode => primary.hashCode ^ number.hashCode ^ border.hashCode;
}
