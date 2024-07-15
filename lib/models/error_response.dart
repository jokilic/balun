class ErrorResponse {
  final DateTime? time;
  final String? bug;
  final String? report;

  ErrorResponse({
    this.time,
    this.bug,
    this.report,
  });

  factory ErrorResponse.fromMap(Map<String, dynamic> map) => ErrorResponse(
        time: map['time'] != null ? DateTime.fromMillisecondsSinceEpoch(map['time'] as int) : null,
        bug: map['bug'] != null ? map['bug'] as String : null,
        report: map['report'] != null ? map['report'] as String : null,
      );

  @override
  String toString() => 'ErrorResponse(time: $time, bug: $bug, report: $report)';

  @override
  bool operator ==(covariant ErrorResponse other) {
    if (identical(this, other)) {
      return true;
    }

    return other.time == time && other.bug == bug && other.report == report;
  }

  @override
  int get hashCode => time.hashCode ^ bug.hashCode ^ report.hashCode;
}
