import 'package:flutter/material.dart';

import '../../../models/fixtures/fixture_response.dart';
import '../../../routing.dart';
import '../../../theme/theme.dart';
import '../../../util/fixtures.dart';
import 'fixtures_list_tile/fixtures_list_tile.dart';

class FixturesSuccess extends StatelessWidget {
  final List<FixtureResponse> fixtures;

  const FixturesSuccess({
    required this.fixtures,
  });

  @override
  Widget build(BuildContext context) {
    final groupedFixtures = groupFixtures(fixtures);

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16),
      physics: const BouncingScrollPhysics(),
      itemCount: groupedFixtures.length,
      itemBuilder: (_, countryIndex) {
        final country = groupedFixtures.keys.elementAtOrNull(countryIndex);
        final leagues = groupedFixtures[country];

        return Column(
          children: [
            ///
            /// COUNTRY TITLE
            ///
            if (country != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  country,
                  style: context.textStyles.fixturesCountry,
                  textAlign: TextAlign.center,
                ),
              ),

            ///
            /// LEAGUES
            ///
            ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 16),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: leagues?.length,
              itemBuilder: (_, leagueIndex) {
                final leagueName = leagues?.keys.elementAtOrNull(leagueIndex);
                final fixtures = leagues?[leagueName];

                return Column(
                  children: [
                    ///
                    /// LEAGUE TITLE
                    ///
                    if (leagueName != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          leagueName,
                          style: context.textStyles.fixturesLeague,
                          textAlign: TextAlign.center,
                        ),
                      ),

                    ///
                    /// FIXTURES
                    ///
                    ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: fixtures?.length,
                      itemBuilder: (_, fixtureIndex) {
                        final fixture = fixtures![fixtureIndex];

                        return FixturesListTile(
                          fixture: fixture,
                          fixturePressed: fixture.fixture?.id != null
                              ? () => openMatch(
                                    context,
                                    matchId: fixture.fixture!.id!,
                                  )
                              : null,
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }
}
