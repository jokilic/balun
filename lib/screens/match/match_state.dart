import '../../models/fixtures/fixture_response.dart';

sealed class MatchState {}

class MatchStateInitial extends MatchState {}

class MatchStateLoading extends MatchState {
  final String? loadingStatus;

  MatchStateLoading({
    this.loadingStatus,
  });
}

class MatchStateEmpty extends MatchState {}

class MatchStateError extends MatchState {
  final String? error;

  MatchStateError({
    required this.error,
  });
}

class MatchStateSuccess extends MatchState {
  final FixtureResponse match;

  MatchStateSuccess({
    required this.match,
  });
}
