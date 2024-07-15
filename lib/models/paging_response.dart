class PagingResponse {
  final int? current;
  final int? total;

  PagingResponse({
    this.current,
    this.total,
  });

  factory PagingResponse.fromMap(Map<String, dynamic> map) => PagingResponse(
        current: map['current'] != null ? map['current'] as int : null,
        total: map['total'] != null ? map['total'] as int : null,
      );

  @override
  String toString() => 'PagingResponse(current: $current, total: $total)';

  @override
  bool operator ==(covariant PagingResponse other) {
    if (identical(this, other)) {
      return true;
    }

    return other.current == current && other.total == total;
  }

  @override
  int get hashCode => current.hashCode ^ total.hashCode;
}
