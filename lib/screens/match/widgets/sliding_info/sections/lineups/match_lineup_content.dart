import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/lineup/lineup.dart';
import '../../../../../../routing.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/lineups.dart';
import '../../../../../../widgets/balun_button.dart';
import 'match_lineups_list.dart';
import 'match_lineups_start_xi.dart';

class MatchLineupContent extends StatelessWidget {
  final Lineup? homeLineup;
  final Lineup? awayLineup;
  final int season;

  const MatchLineupContent({
    required this.homeLineup,
    required this.awayLineup,
    required this.season,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: [
          ///
          /// STARTING 11
          ///
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Starting 11',
              style: context.textStyles.matchLineupsSectionTitle,
            ),
          ),
          const SizedBox(height: 12),
          MatchLineupsStartXI(
            homeLineup: homeLineup,
            awayLineup: awayLineup,
            season: season,
          ),
          const SizedBox(height: 12),

          ///
          /// MANAGERS
          ///
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Managers',
              style: context.textStyles.matchLineupsSectionTitle,
            ),
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
                      homeLineup?.coach?.name ?? '---',
                      style: context.textStyles.matchStandingsSectionTextAlternate,
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
                      awayLineup?.coach?.name ?? '---',
                      style: context.textStyles.matchStandingsSectionTextAlternate,
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
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Substitutions',
              style: context.textStyles.matchLineupsSectionTitle,
            ),
          ),
          const SizedBox(height: 12),
          MatchLineupsList(
            homePlayers: sortPlayersByPosition(
              homeLineup?.substitutes,
            ),
            awayPlayers: sortPlayersByPosition(
              awayLineup?.substitutes,
            ),
            homePlayerColors: homeLineup?.team?.colors,
            awayPlayerColors: awayLineup?.team?.colors,
            season: season,
          ),

          const SizedBox(height: 24),
        ],
      );
}
