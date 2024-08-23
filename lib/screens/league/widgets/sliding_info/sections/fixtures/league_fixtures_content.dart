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
    final groupedFixtures = getGroupedFixtures(fixtures ?? []);

    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
      physics: const BouncingScrollPhysics(),
      children: groupedFixtures.entries
          .map(
            (entry) => LeagueFixturesGroup(
              round: entry.key,
              fixtures: entry.value,
            ),
          )
          .toList(),
    );
  }
}
