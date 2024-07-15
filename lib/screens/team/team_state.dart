import '../../models/teams/team_response.dart';

sealed class TeamState {}

class TeamStateInitial extends TeamState {}

class TeamStateLoading extends TeamState {
  final String? loadingStatus;

  TeamStateLoading({
    this.loadingStatus,
  });
}

class TeamStateEmpty extends TeamState {}

class TeamStateError extends TeamState {
  final String? error;

  TeamStateError({
    required this.error,
  });
}

class TeamStateSuccess extends TeamState {
  final TeamResponse team;

  TeamStateSuccess({
    required this.team,
  });
}
