import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/fixture_response.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/league_fixtures.dart';
import 'league_fixtures_group.dart';

class LeagueFixturesContent extends StatelessWidget {
  final List<FixtureResponse>? fixtures;

  const LeagueFixturesContent({
    required this.fixtures,
  });

  @override
  Widget build(BuildContext context) {
    final groupedFixtures = splitAndGroupLeagueFixtures(
      fixtures ?? [],
      currentDate: DateTime.now(),
    );

    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
      physics: const NeverScrollableScrollPhysics(),
      children: [
        if (groupedFixtures.futureGroups.isNotEmpty) ...[
          Text(
            'leagueFixturesUpcoming'.tr(),
            style: context.textStyles.matchStandingsSectionSubtitle,
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 16, bottom: 28),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: groupedFixtures.futureGroups.entries.length,
            itemBuilder: (_, index) {
              final entry = groupedFixtures.futureGroups.entries.toList()[index];

              return LeagueFixturesGroup(
                round: entry.key,
                fixtures: entry.value,
                initiallyExpanded: index == 0,
              );
            },
          ),
        ],
        Text(
          groupedFixtures.futureGroups.isNotEmpty ? 'leagueFixturesPlayed'.tr() : 'leagueFixturesAll'.tr(),
          style: context.textStyles.matchStandingsSectionSubtitle,
        ),
        ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 16),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: groupedFixtures.pastGroups.entries.length,
          itemBuilder: (_, index) {
            final entry = groupedFixtures.pastGroups.entries.toList()[index];

            return LeagueFixturesGroup(
              round: entry.key,
              fixtures: entry.value,
            );
          },
        ),
      ],
    );
  }
}
