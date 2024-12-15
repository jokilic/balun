import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/fixture_response.dart';
import '../../../../../../util/league_fixtures.dart';
import 'league_fixtures_group.dart';

class LeagueFixturesContent extends StatelessWidget {
  final List<FixtureResponse>? fixtures;

  const LeagueFixturesContent({
    required this.fixtures,
  });

  @override
  Widget build(BuildContext context) {
    final groupedFixtures = groupLeagueFixtures(
      fixtures ?? [],
    );

    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: groupedFixtures.entries.length,
      itemBuilder: (_, index) {
        final entry = groupedFixtures.entries.toList()[index];

        return LeagueFixturesGroup(
          round: entry.key,
          fixtures: entry.value,
        );
      },
    );
  }
}
