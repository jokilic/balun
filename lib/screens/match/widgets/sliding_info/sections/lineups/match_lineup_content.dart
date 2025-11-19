import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/lineup/lineup.dart';
import '../../../../../../models/fixtures/player_statistic/player_statistic.dart';
import '../../../../../../routing.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/lineups.dart';
import '../../../../../../util/word_mix.dart';
import '../../../../../../widgets/balun_button.dart';
import 'match_lineup_team_data.dart';
import 'match_lineups_list.dart';
import 'match_lineups_start_xi.dart';

class MatchLineupContent extends StatelessWidget {
  final bool matchLive;
  final Lineup? homeLineup;
  final Lineup? awayLineup;
  final PlayerStatistic? homePlayerStatistic;
  final PlayerStatistic? awayPlayerStatistic;
  final int? matchElapsed;
  final String season;

  const MatchLineupContent({
    required this.matchLive,
    required this.homeLineup,
    required this.awayLineup,
    required this.homePlayerStatistic,
    required this.awayPlayerStatistic,
    required this.matchElapsed,
    required this.season,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: [
          ///
          /// HOME TEAM
          ///
          MatchLineupTeamData(
            matchLive: matchLive,
            lineup: homeLineup,
            playerStatistic: homePlayerStatistic,
          ),
          const SizedBox(height: 24),

          ///
          /// START XI
          ///
          MatchLineupsStartXI(
            matchLive: matchLive,
            homeLineup: homeLineup,
            awayLineup: awayLineup,
            homePlayerStatistic: homePlayerStatistic,
            awayPlayerStatistic: awayPlayerStatistic,
            matchElapsed: matchElapsed,
            season: season,
          ),
          const SizedBox(height: 24),

          ///
          /// AWAY TEAM
          ///
          MatchLineupTeamData(
            matchLive: matchLive,
            lineup: awayLineup,
            playerStatistic: awayPlayerStatistic,
          ),

          ///
          /// MANAGERS
          ///
          const SizedBox(height: 28),
          Text(
            'matchLineupManagers'.tr(),
            style: context.textStyles.headlineMdBold,
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: BalunButton(
                  onPressed: homeLineup?.coach?.id != null
                      ? () => openCoach(
                            context,
                            coachId: homeLineup!.coach!.id!,
                          )
                      : null,
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      mixOrOriginalWords(homeLineup?.coach?.name ?? '---') ?? '---',
                      style: context.textStyles.titleMd,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: BalunButton(
                  onPressed: awayLineup?.coach?.id != null
                      ? () => openCoach(
                            context,
                            coachId: awayLineup!.coach!.id!,
                          )
                      : null,
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      mixOrOriginalWords(awayLineup?.coach?.name ?? '---') ?? '---',
                      style: context.textStyles.titleMd,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          ///
          /// SUBSTITUTIONS
          ///
          Text(
            'matchLineupSubstitutions'.tr(),
            style: context.textStyles.headlineMdBold,
          ),
          const SizedBox(height: 16),
          MatchLineupsList(
            matchLive: matchLive,
            homePlayers: sortPlayersByPosition(
              homeLineup?.substitutes,
            ),
            awayPlayers: sortPlayersByPosition(
              awayLineup?.substitutes,
            ),
            homePlayerStatistic: homePlayerStatistic,
            awayPlayerStatistic: awayPlayerStatistic,
            homePlayerColors: homeLineup?.team?.colors,
            awayPlayerColors: awayLineup?.team?.colors,
            season: season,
          ),

          const SizedBox(height: 24),
        ],
      );
}
