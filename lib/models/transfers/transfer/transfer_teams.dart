import 'transfer_team.dart';

class TransferTeams {
  final TransferTeam? teamIn;
  final TransferTeam? teamOut;

  TransferTeams({
    this.teamIn,
    this.teamOut,
  });

  factory TransferTeams.fromMap(Map<String, dynamic> map) => TransferTeams(
        teamIn: map['in'] != null ? TransferTeam.fromMap(map['in'] as Map<String, dynamic>) : null,
        teamOut: map['out'] != null ? TransferTeam.fromMap(map['out'] as Map<String, dynamic>) : null,
      );

  @override
  String toString() => 'TransferTeams(teamIn: $teamIn, teamOut: $teamOut)';

  @override
  bool operator ==(covariant TransferTeams other) {
    if (identical(this, other)) {
      return true;
    }

    return other.teamIn == teamIn && other.teamOut == teamOut;
  }

  @override
  int get hashCode => teamIn.hashCode ^ teamOut.hashCode;
}
