class EventAssist {
  final int? id;
  final String? name;

  EventAssist({
    this.id,
    this.name,
  });

  factory EventAssist.fromMap(Map<String, dynamic> map) => EventAssist(
        id: map['id'] != null ? map['id'] as int : null,
        name: map['name'] != null ? map['name'] as String : null,
      );

  @override
  String toString() => 'EventAssist(id: $id, name: $name)';

  @override
  bool operator ==(covariant EventAssist other) {
    if (identical(this, other)) {
      return true;
    }

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
