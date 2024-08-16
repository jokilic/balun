import 'transfer_teams.dart';

class Transfer {
  final DateTime? date;
  final String? type;
  final TransferTeams? teams;

  Transfer({
    this.date,
    this.type,
    this.teams,
  });

  factory Transfer.fromMap(Map<String, dynamic> map) => Transfer(
        date: map['date'] != null ? DateTime.tryParse(map['date'] as String) : null,
        type: map['type'] != null ? map['type'] as String : null,
        teams: map['teams'] != null ? TransferTeams.fromMap(map['teams'] as Map<String, dynamic>) : null,
      );

  @override
  String toString() => 'Transfer(date: $date, type: $type, teams: $teams)';

  @override
  bool operator ==(covariant Transfer other) {
    if (identical(this, other)) {
      return true;
    }

    return other.date == date && other.type == type && other.teams == teams;
  }

  @override
  int get hashCode => date.hashCode ^ type.hashCode ^ teams.hashCode;
}
