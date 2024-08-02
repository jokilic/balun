import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../models/fixtures/fixture_response.dart';
import '../../../../models/match_section.dart';
import '../../../../util/events.dart';
import 'sections/events/match_events_section.dart';
import 'sections/h2h/match_h2h_section.dart';
import 'sections/lineups/match_lineups_section.dart';
import 'sections/match_info_section.dart';
import 'sections/match_injuries_section.dart';
import 'sections/player_statistics/match_player_statistics_section.dart';
import 'sections/standings/match_standings_section.dart';
import 'sections/statistics/match_statistics_section.dart';

class MatchActiveSection extends StatelessWidget {
  final FixtureResponse match;
  final MatchSection matchSection;

  const MatchActiveSection({
    required this.match,
    required this.matchSection,
  });

  @override
  Widget build(BuildContext context) => switch (matchSection) {
        MatchSection(
          matchSectionEnum: MatchSectionEnum.info,
        ) =>
          MatchInfoSection(
            timestamp: match.fixture?.timestamp,
            referee: match.fixture?.referee,
            venue: match.fixture?.venue,
            status: match.fixture?.status,
            league: match.league,
          ),
        MatchSection(
          matchSectionEnum: MatchSectionEnum.standings,
        ) =>
          MatchStandingsSection(
            leagueId: match.league?.id,
            season: match.league?.season,
          ),
        MatchSection(
          matchSectionEnum: MatchSectionEnum.events,
        ) =>
          MatchEventsSection(
            eventsScoresList: getEventsList(
              events: match.events,
              score: match.score,
            ),
            awayTeamId: match.teams?.away?.id,
          ),
        MatchSection(
          matchSectionEnum: MatchSectionEnum.lineups,
        ) =>
          MatchLineupsSection(
            homeLineup: match.lineups?.firstWhere(
              (lineup) => lineup.team?.id == match.teams?.home?.id,
            ),
            awayLineup: match.lineups?.firstWhere(
              (lineup) => lineup.team?.id == match.teams?.away?.id,
            ),
          ),
        MatchSection(
          matchSectionEnum: MatchSectionEnum.headToHead,
        ) =>
          MatchHead2HeadSection(
            homeTeamId: match.teams?.home?.id,
            awayTeamId: match.teams?.away?.id,
          ),
        MatchSection(
          matchSectionEnum: MatchSectionEnum.statistics,
        ) =>
          MatchStatisticsSection(
            homeStatistic: match.statistics?.firstWhere(
              (statistic) => statistic.team?.id == match.teams?.home?.id,
            ),
            awayStatistic: match.statistics?.firstWhere(
              (statistic) => statistic.team?.id == match.teams?.away?.id,
            ),
          ),
        MatchSection(
          matchSectionEnum: MatchSectionEnum.playerStatistics,
        ) =>
          MatchPlayerStatisticsSection(
            homePlayerStatistic: match.playerStatistics?.firstWhere(
              (playerStatistic) => playerStatistic.team?.id == match.teams?.home?.id,
            ),
            awayPlayerStatistic: match.playerStatistics?.firstWhere(
              (playerStatistic) => playerStatistic.team?.id == match.teams?.away?.id,
            ),
          ),
        MatchSection(
          matchSectionEnum: MatchSectionEnum.injuries,
        ) =>
          MatchInjuriesSection(),
      };
}
