import 'package:flutter/material.dart';

import '../../../models/fixtures/fixture_response.dart';
import '../../../util/fixtures.dart';
import 'fixtures_app_bar.dart';
import 'fixtures_list_tile/fixtures_country/fixtures_country_list_tile.dart';

class FixturesSuccess extends StatelessWidget {
  final List<FixtureResponse> fixtures;

  const FixturesSuccess({
    required this.fixtures,
  });

  @override
  Widget build(BuildContext context) {
    final popularSortedGroupedFixtures = sortGroupedFixtures(
      groupFixtures(
        getPopularFixtures(fixtures),
      ),
    );

    final sortedGroupedFixtures = sortGroupedFixtures(
      groupFixtures(fixtures),
    );

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      physics: const BouncingScrollPhysics(),
      children: [
        ///
        /// POPULAR FIXTURES
        ///
        if (popularSortedGroupedFixtures.isNotEmpty) ...[
          const SizedBox(height: 8),
          FixturesAppBar(
            onPressed: () {},
            text: 'Popular fixtures',
          ),
          const SizedBox(height: 24),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: popularSortedGroupedFixtures.length,
            itemBuilder: (_, countryIndex) {
              final countryLeague = popularSortedGroupedFixtures.keys.elementAtOrNull(countryIndex);
              final leagues = popularSortedGroupedFixtures[countryLeague];

              return FixturesCountryListTile(
                countryLeague: countryLeague,
                leagues: leagues,
                initiallyExpanded: true,
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 12),
          ),
        ],

        ///
        /// SORTED GROUPED FIXTURES
        ///
        if (sortedGroupedFixtures.isNotEmpty) ...[
          const SizedBox(height: 40),
          FixturesAppBar(
            onPressed: () {},
            text: 'Other fixtures',
          ),
          const SizedBox(height: 24),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sortedGroupedFixtures.length,
            itemBuilder: (_, countryIndex) {
              final countryLeague = sortedGroupedFixtures.keys.elementAtOrNull(countryIndex);
              final leagues = sortedGroupedFixtures[countryLeague];

              return FixturesCountryListTile(
                countryLeague: countryLeague,
                leagues: leagues,
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 12),
          ),
        ],
      ],
    );
  }
}
