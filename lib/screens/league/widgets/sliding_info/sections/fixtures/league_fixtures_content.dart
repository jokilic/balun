import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../../../../models/fixtures/fixture_response.dart';
import '../../../../../../routing.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/fixtures.dart';
import 'league_fixtures_list_tile.dart';

class LeagueFixturesContent extends StatelessWidget {
  final List<FixtureResponse>? fixtures;

  const LeagueFixturesContent({
    required this.fixtures,
  });

  @override
  Widget build(BuildContext context) => GroupedListView<FixtureResponse, String>(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        physics: const BouncingScrollPhysics(),
        elements: fixtures ?? [],
        groupBy: (fixture) => fixture.league?.round ?? '',
        groupSeparatorBuilder: (groupByValue) => Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 32, bottom: 16),
            child: Text(
              groupByValue,
              style: context.textStyles.leagueFixturesTitle,
            ),
          ),
        ),
        separator: const SizedBox(height: 24),
        groupComparator: compareRounds,
        itemBuilder: (_, fixture) => LeagueFixturesListTile(
          fixture: fixture,
          fixturePressed: () => openMatch(
            context,
            matchId: fixture.fixture!.id!,
          ),
        ),
      );
}
