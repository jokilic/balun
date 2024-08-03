import '../models/fixtures/fixture_response.dart';

List<FixtureResponse>? getHead2HeadList({required List<FixtureResponse> fixtures}) => fixtures
  ..sort(
    (a, b) {
      final aDate = a.fixture?.timestamp ?? DateTime.now();
      final bDate = b.fixture?.timestamp ?? DateTime.now();

      return aDate.compareTo(bDate);
    },
  );
