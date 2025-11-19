import 'package:flutter/material.dart';

import '../../../../../../constants.dart';
import '../../../../../../models/player_teams/player_team_response.dart';
import '../../../../../../routing.dart';
import '../../../../../../theme/icons.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/word_mix.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image.dart';

class PlayerTeamsListTile extends StatefulWidget {
  final PlayerTeamResponse? team;

  const PlayerTeamsListTile({
    required this.team,
  });

  @override
  State<PlayerTeamsListTile> createState() => _PlayerTeamsListTileState();
}

class _PlayerTeamsListTileState extends State<PlayerTeamsListTile> {
  var expanded = false;

  void toggleExpanded() => setState(
    () => expanded = !expanded,
  );

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Column(
      children: [
        ///
        /// NAME
        ///
        BalunButton(
          onPressed: toggleExpanded,
          child: Container(
            color: Colors.transparent,
            child: Row(
              children: [
                ///
                /// LOGO
                ///
                BalunImage(
                  imageUrl: widget.team?.team?.logo ?? BalunIcons.placeholderTeam,
                  height: 56,
                  width: 56,
                ),
                const SizedBox(width: 12),

                ///
                /// NAME
                ///
                Expanded(
                  child: Text(
                    mixOrOriginalWords(widget.team?.team?.name) ?? '--',
                    style: context.textStyles.titleMd,
                  ),
                ),
              ],
            ),
          ),
        ),

        ///
        /// SEASONS
        ///
        if (widget.team?.seasons?.isNotEmpty ?? false)
          AnimatedSize(
            duration: BalunConstants.expandDuration,
            curve: Curves.easeIn,
            child: expanded
                ? Padding(
                    padding: const EdgeInsets.only(top: 28, bottom: 8),
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: widget.team!.seasons!
                          .map(
                            (season) => BalunButton(
                              onPressed: widget.team?.team?.id != null
                                  ? () => openTeam(
                                      context,
                                      teamId: widget.team!.team!.id!,
                                      season: season.toString(),
                                    )
                                  : null,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: context.colors.primaryForeground,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '$season',
                                  style: context.textStyles.titleMdBold,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
      ],
    ),
  );
}
