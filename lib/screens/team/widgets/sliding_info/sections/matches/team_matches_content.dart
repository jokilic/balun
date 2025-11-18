import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/fixture_response.dart';
import '../../../../../../routing.dart';
import '../../../../../../util/h2h.dart';
import '../../../../../../util/string.dart';
import 'team_matches_list_tile.dart';

class TeamMatchesContent extends StatelessWidget {
  final List<FixtureResponse>? fixtures;

  const TeamMatchesContent({
    required this.fixtures,
  });

  @override
  Widget build(BuildContext context) {
    final sortedFixtures = getHead2HeadList(
      fixtures: fixtures ?? [],
    );

    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sortedFixtures?.length ?? 0,
      itemBuilder: (_, index) {
        final fixture = sortedFixtures![index];

        return TeamMatchesListTile(
          fixture: fixture,
          fixturePlaying: isMatchPlaying(
            statusShort: fixture.fixture?.status?.short ?? '--',
          ),
          fixturePressed: () => openMatch(
            context,
            matchId: fixture.fixture!.id!,
          ),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 12),
    );
  }
}
