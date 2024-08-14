import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/fixture_response.dart';
import '../../../../../../routing.dart';
import 'league_fixtures_list_tile.dart';

class LeagueFixturesContent extends StatelessWidget {
  final List<FixtureResponse>? fixtures;

  const LeagueFixturesContent({
    required this.fixtures,
  });

  @override
  Widget build(BuildContext context) => ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        physics: const BouncingScrollPhysics(),
        itemCount: fixtures?.length ?? 0,
        itemBuilder: (_, index) {
          final fixture = fixtures![index];

          return LeagueFixturesListTile(
            fixture: fixture,
            fixturePressed: () => openMatch(
              context,
              matchId: fixture.fixture!.id!,
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 8),
      );
}
