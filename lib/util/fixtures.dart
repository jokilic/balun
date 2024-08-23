import '../models/fixtures/fixture_response.dart';

Map<String, Map<String, List<FixtureResponse>>> groupFixtures(List<FixtureResponse> fixtures) {
  final groupedData = <String, Map<String, List<FixtureResponse>>>{};

  for (final fixture in fixtures) {
    if (fixture.league != null) {
      final country = fixture.league!.country ?? 'Unknown';
      final leagueName = fixture.league!.name ?? 'Unknown';

      /// Create country group if it doesn't exist
      groupedData.putIfAbsent(country, () => {});

      /// Create league group if it doesn't exist
      groupedData[country]?.putIfAbsent(leagueName, () => []);

      // Add the current fixture to the appropriate group
      groupedData[country]?[leagueName]?.add(fixture);
    }
  }

  return groupedData;
}
