import '../models/fixtures/fixture_response.dart';

List<FixtureResponse>? sortTeamFixturesUpcoming({required List<FixtureResponse> fixtures}) => fixtures
  ..sort(
    (a, b) {
      final aDate = a.fixture?.timestamp ?? DateTime.fromMillisecondsSinceEpoch(0);
      final bDate = b.fixture?.timestamp ?? DateTime.fromMillisecondsSinceEpoch(0);

      return aDate.compareTo(bDate);
    },
  );

List<FixtureResponse>? sortTeamFixturesPlayed({required List<FixtureResponse> fixtures}) => fixtures
  ..sort(
    (a, b) {
      final aDate = a.fixture?.timestamp ?? DateTime.fromMillisecondsSinceEpoch(0);
      final bDate = b.fixture?.timestamp ?? DateTime.fromMillisecondsSinceEpoch(0);

      return bDate.compareTo(aDate);
    },
  );
