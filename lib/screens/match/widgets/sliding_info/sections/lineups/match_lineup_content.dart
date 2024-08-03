import 'package:flutter/material.dart';

import '../../../../../../constants.dart';
import '../../../../../../models/fixtures/lineup/lineup.dart';
import '../../../../../../routing.dart';
import '../../../../../../theme/icons.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/lineups.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image.dart';
import 'match_lineup_list.dart';
import 'match_lineup_start_xi.dart';

class MatchLineupContent extends StatefulWidget {
  final Lineup? lineup;

  const MatchLineupContent({
    required this.lineup,
  });

  @override
  State<MatchLineupContent> createState() => _MatchLineupContentState();
}

class _MatchLineupContentState extends State<MatchLineupContent> {
  var expanded = false;

  void toggleExpanded() => setState(
        () => expanded = !expanded,
      );

  @override
  Widget build(BuildContext context) => Column(
        children: [
          ///
          /// INFO
          ///
          if (widget.lineup?.team != null) ...[
            BalunButton(
              onPressed: toggleExpanded,
              child: Container(
                color: Colors.transparent,
                child: Row(
                  children: [
                    BalunButton(
                      onPressed: widget.lineup?.team?.id != null
                          ? () => openTeam(
                                context,
                                teamId: widget.lineup!.team!.id!,
                              )
                          : null,
                      child: BalunImage(
                        imageUrl: widget.lineup!.team!.logo!,
                        height: 64,
                        width: 64,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.lineup!.team!.name ?? '---',
                            style: context.textStyles.matchLineupsSectionTitle,
                          ),
                          if (widget.lineup?.coach != null) ...[
                            const SizedBox(height: 4),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Manager',
                                  style: context.textStyles.matchLineupsSectionTextSmall,
                                ),
                                Text(
                                  widget.lineup!.coach!.name ?? '---',
                                  style: context.textStyles.matchLineupsSectionText,
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: expanded ? 0 : 1,
                      duration: BalunConstants.animationDuration,
                      curve: Curves.easeIn,
                      child: Image.asset(
                        BalunIcons.arrowDown,
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 4),
          ],

          ///
          /// LINEUP
          ///
          if (widget.lineup?.startXI?.isNotEmpty ?? false) ...[
            AnimatedSize(
              duration: BalunConstants.animationDuration,
              curve: Curves.easeIn,
              child: expanded
                  ? Column(
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
                        MatchLineupStartXI(
                          lineup: widget.lineup,
                        ),

                        const SizedBox(height: 24),

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
                        MatchLineupList(
                          players: sortPlayersByPosition(
                            widget.lineup?.substitutes,
                          ),
                          playerColors: widget.lineup?.team?.colors,
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ],
      );
}
