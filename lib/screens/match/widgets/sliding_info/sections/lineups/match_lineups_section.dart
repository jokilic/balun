import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/lineup/lineup.dart';
import '../../../../../../routing.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image.dart';
import 'match_lineup_start_xi.dart';

class MatchLineupsSection extends StatelessWidget {
  final Lineup? homeLineup;
  final Lineup? awayLineup;

  const MatchLineupsSection({
    required this.homeLineup,
    required this.awayLineup,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Column(
          children: [
            ///
            /// HOME INFO
            ///
            if (homeLineup?.team != null) ...[
              Row(
                children: [
                  BalunButton(
                    onPressed: homeLineup?.team?.id != null
                        ? () => openTeam(
                              context,
                              teamId: homeLineup!.team!.id!,
                            )
                        : null,
                    child: BalunImage(
                      imageUrl: homeLineup!.team!.logo!,
                      height: 64,
                      width: 64,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BalunButton(
                          onPressed: homeLineup?.team?.id != null
                              ? () => openTeam(
                                    context,
                                    teamId: homeLineup!.team!.id!,
                                  )
                              : null,
                          child: Text(
                            homeLineup!.team!.name ?? '---',
                            style: context.textStyles.matchLineupsSectionTitle,
                          ),
                        ),
                        if (homeLineup?.coach != null) ...[
                          const SizedBox(height: 4),
                          BalunButton(
                            onPressed: homeLineup?.coach?.id != null
                                ? () => openCoach(
                                      context,
                                      coachId: homeLineup!.coach!.id!,
                                    )
                                : null,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Manager',
                                  style: context.textStyles.matchLineupsSectionTextSmall,
                                ),
                                Text(
                                  homeLineup!.coach!.name ?? '---',
                                  style: context.textStyles.matchLineupsSectionText,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],

            ///
            /// HOME LINEUP
            ///
            if (homeLineup?.startXI?.isNotEmpty ?? false) ...[
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Starting 11',
                  style: context.textStyles.matchLineupsSectionTitle,
                ),
              ),
              const SizedBox(height: 12),
              MatchLineupStartXI(
                lineup: homeLineup,
              ),
            ],

            Container(
              margin: const EdgeInsets.all(24),
              height: 4,
              color: Colors.green,
            ),

            ///
            /// AWAY LINEUP
            ///
            if ((awayLineup != null) && (awayLineup?.startXI?.isNotEmpty ?? false))
              MatchLineupStartXI(
                lineup: awayLineup,
              ),
          ],
        ),
      );
}
