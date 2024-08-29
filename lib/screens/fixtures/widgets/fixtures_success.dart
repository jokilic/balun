import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/fixtures/fixture_response.dart';
import '../../../util/fixtures.dart';
import 'fixtures_list_tile/fixtures_country/fixtures_country_list_tile.dart';

class FixturesSuccess extends StatelessWidget {
  final List<FixtureResponse> fixtures;

  const FixturesSuccess({
    required this.fixtures,
  });

  @override
  Widget build(BuildContext context) {
    final sortedGroupedFixtures = sortGroupedFixtures(
      groupFixtures(fixtures),
    );

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16),
      physics: const BouncingScrollPhysics(),
      itemCount: sortedGroupedFixtures.length,
      itemBuilder: (_, countryIndex) {
        final countryLeague = sortedGroupedFixtures.keys.elementAtOrNull(countryIndex);
        final leagues = sortedGroupedFixtures[countryLeague];

        return FixturesCountryListTile(
          countryLeague: countryLeague,
          leagues: leagues,
          initiallyExpanded: leagues?.values.any(
                (innerLeagues) => innerLeagues.any(
                  (fixture) => BalunConstants.leaguesOrder.keys.contains(
                    fixture.league?.id,
                  ),
                ),
              ) ??
              false,
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 12),
    );
  }
}
