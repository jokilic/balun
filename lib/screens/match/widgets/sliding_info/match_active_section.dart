import 'package:flutter/material.dart';

import '../../../../models/fixtures/fixture_response.dart';
import '../../../../models/sections/match_section.dart';
import '../../../../util/date_time.dart';
import '../../../../util/events.dart';
import '../../../../util/string.dart';
import 'sections/events/match_events_section.dart';
import 'sections/h2h/match_h2h_section.dart';
import 'sections/highlights/match_highlights_section.dart';
import 'sections/info/match_info_section.dart';
import 'sections/lineups/match_lineups_section.dart';
import 'sections/player_statistics/match_player_statistics_section.dart';
import 'sections/standings/match_standings_section.dart';
import 'sections/statistics/match_statistics_section.dart';

class MatchActiveSection extends StatelessWidget {
  final FixtureResponse match;
  final MatchSection matchSection;
  final String season;

  const MatchActiveSection({
    required this.match,
    required this.matchSection,
    required this.season,
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
          matchSectionEnum: MatchSectionEnum.events,
        ) =>
          MatchEventsSection(
            events: calculatedCardsEvents(match.events),
            score: match.score,
            elapsed: match.fixture?.status?.elapsed,
            awayTeamId: match.teams?.away?.id,
            statusShort: match.fixture?.status?.short ?? '--',
            season: match.league?.season,
          ),
        MatchSection(
          matchSectionEnum: MatchSectionEnum.highlights,
        ) =>
          MatchHighlightsSection(
            matchId: match.fixture?.id,
            homeTeamName: match.teams?.home?.name,
            awayTeamName: match.teams?.away?.name,
            matchDate: match.fixture?.date,
            leagueName: match.league?.name,
          ),
        MatchSection(
          matchSectionEnum: MatchSectionEnum.lineups,
        ) =>
          MatchLineupsSection(
            matchLive: isMatchPlaying(
              statusShort: match.fixture?.status?.short ?? '--',
            ),
            homeLineup: match.lineups
                ?.where(
                  (lineup) => lineup.team?.id == match.teams?.home?.id,
                )
                .firstOrNull,
            awayLineup: match.lineups
                ?.where(
                  (lineup) => lineup.team?.id == match.teams?.away?.id,
                )
                .firstOrNull,
            homePlayerStatistic: match.playerStatistics
                ?.where(
                  (playerStatistic) => playerStatistic.team?.id == match.teams?.home?.id,
                )
                .firstOrNull,
            awayPlayerStatistic: match.playerStatistics
                ?.where(
                  (playerStatistic) => playerStatistic.team?.id == match.teams?.away?.id,
                )
                .firstOrNull,
            matchElapsed: match.fixture?.status?.elapsed,
            season: season,
          ),
        MatchSection(
          matchSectionEnum: MatchSectionEnum.statistics,
        ) =>
          MatchStatisticsSection(
            homeStatistic: match.statistics
                ?.where(
                  (statistic) => statistic.team?.id == match.teams?.home?.id,
                )
                .firstOrNull,
            awayStatistic: match.statistics
                ?.where(
                  (statistic) => statistic.team?.id == match.teams?.away?.id,
                )
                .firstOrNull,
          ),
        MatchSection(
          matchSectionEnum: MatchSectionEnum.playerStatistics,
        ) =>
          MatchPlayerStatisticsSection(
            homePlayerStatistic: match.playerStatistics
                ?.where(
                  (playerStatistic) => playerStatistic.team?.id == match.teams?.home?.id,
                )
                .firstOrNull,
            awayPlayerStatistic: match.playerStatistics
                ?.where(
                  (playerStatistic) => playerStatistic.team?.id == match.teams?.away?.id,
                )
                .firstOrNull,
            season: match.league?.season ?? getCurrentSeasonYear().toString(),
          ),
        MatchSection(
          matchSectionEnum: MatchSectionEnum.standings,
        ) =>
          MatchStandingsSection(
            matchId: match.fixture?.id,
            leagueId: match.league?.id,
            season: match.league?.season,
          ),
        MatchSection(
          matchSectionEnum: MatchSectionEnum.headToHead,
        ) =>
          MatchHead2HeadSection(
            matchId: match.fixture?.id,
            homeTeamId: match.teams?.home?.id,
            awayTeamId: match.teams?.away?.id,
          ),
      };
}
