class SidelinedInnerResponse {
  final String? type;
  final DateTime? start;
  final DateTime? end;

  SidelinedInnerResponse({
    this.type,
    this.start,
    this.end,
  });

  factory SidelinedInnerResponse.fromMap(Map<String, dynamic> map) => SidelinedInnerResponse(
        type: map['type'] != null ? map['type'] as String : null,
        start: map['start'] != null ? DateTime.tryParse(map['start'] as String) : null,
        end: map['end'] != null ? DateTime.tryParse(map['end'] as String) : null,
      );

  @override
  String toString() => 'SidelinedInnerResponse(type: $type, start: $start, end: $end)';

  @override
  bool operator ==(covariant SidelinedInnerResponse other) {
    if (identical(this, other)) {
      return true;
    }

    return other.type == type && other.start == start && other.end == end;
  }

  @override
  int get hashCode => type.hashCode ^ start.hashCode ^ end.hashCode;
}
