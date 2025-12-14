import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../models/fixtures/fixture_response.dart';
import '../../../../../../routing.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/string.dart';
import '../../../../../../util/team_fixtures.dart';
import 'team_matches_list_tile.dart';

class TeamMatchesContent extends StatelessWidget {
  final ({List<FixtureResponse> upcomingFixtures, List<FixtureResponse> playedFixtures}) fixtures;

  const TeamMatchesContent({
    required this.fixtures,
  });

  @override
  Widget build(BuildContext context) {
    final sortedUpcomingFixtures = sortTeamFixturesUpcoming(
      fixtures: fixtures.upcomingFixtures,
    );

    final sortedPlayedFixtures = sortTeamFixturesPlayed(
      fixtures: fixtures.playedFixtures,
    );

    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
      physics: const NeverScrollableScrollPhysics(),
      children: [
        ///
        /// UPCOMING FIXTURES
        ///
        if (sortedUpcomingFixtures?.isNotEmpty ?? false) ...[
          Text(
            'fixturesUpcoming'.tr(),
            style: context.textStyles.headlineMd,
          ),
          ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 16, bottom: 28),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sortedUpcomingFixtures!.length,
            itemBuilder: (_, index) {
              final fixture = sortedUpcomingFixtures[index];

              return TeamMatchesListTile(
                fixture: fixture,
                fixturePlaying: isMatchPlaying(
                  statusShort: fixture.fixture?.status?.short ?? '--',
                ),
                fixturePressed: () {
                  HapticFeedback.lightImpact();
                  openMatch(
                    context,
                    matchId: fixture.fixture!.id!,
                  );
                },
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 12),
          ),
        ],

        ///
        /// PLAYED FIXTURES
        ///
        if (sortedPlayedFixtures?.isNotEmpty ?? false) ...[
          Text(
            'fixturesPlayed'.tr(),
            style: context.textStyles.headlineMd,
          ),
          ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 16),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sortedPlayedFixtures!.length,
            itemBuilder: (_, index) {
              final fixture = sortedPlayedFixtures[index];

              return TeamMatchesListTile(
                fixture: fixture,
                fixturePlaying: isMatchPlaying(
                  statusShort: fixture.fixture?.status?.short ?? '--',
                ),
                fixturePressed: () {
                  HapticFeedback.lightImpact();
                  openMatch(
                    context,
                    matchId: fixture.fixture!.id!,
                  );
                },
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 12),
          ),
        ],
      ],
    );
  }
}
