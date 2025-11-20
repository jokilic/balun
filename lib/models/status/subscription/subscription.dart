class Subscription {
  final String? plan;
  final DateTime? end;
  final bool? active;

  Subscription({
    this.plan,
    this.end,
    this.active,
  });

  factory Subscription.fromMap(Map<String, dynamic> map) => Subscription(
    plan: map['plan'] != null ? map['plan'] as String : null,
    end: map['end'] != null ? DateTime.tryParse(map['end'] as String) : null,
    active: map['active'] != null ? map['active'] as bool : null,
  );

  @override
  String toString() => 'Subscription(plan: $plan, end: $end, active: $active)';

  @override
  bool operator ==(covariant Subscription other) {
    if (identical(this, other)) {
      return true;
    }

    return other.plan == plan && other.end == end && other.active == active;
  }

  @override
  int get hashCode => plan.hashCode ^ end.hashCode ^ active.hashCode;
}
