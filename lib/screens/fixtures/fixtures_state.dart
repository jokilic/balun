import '../../models/fixtures/fixture_response.dart';

sealed class FixturesState {}

class FixturesStateInitial extends FixturesState {}

class FixturesStateLoading extends FixturesState {
  final String? loadingStatus;

  FixturesStateLoading({
    this.loadingStatus,
  });
}

class FixturesStateEmpty extends FixturesState {}

class FixturesStateError extends FixturesState {
  final String? error;

  FixturesStateError({
    required this.error,
  });
}

class FixturesStateSuccess extends FixturesState {
  final List<FixtureResponse> fixtures;

  FixturesStateSuccess({
    required this.fixtures,
  });
}
