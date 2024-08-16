import 'package:flutter/material.dart';

import '../../../../../../constants.dart';
import '../../../../../../models/squads/player/player.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image.dart';

class TeamPlayersListTile extends StatefulWidget {
  final Player player;

  const TeamPlayersListTile({
    required this.player,
  });

  @override
  State<TeamPlayersListTile> createState() => _TeamPlayersListTileState();
}

class _TeamPlayersListTileState extends State<TeamPlayersListTile> {
  var expanded = false;

  void toggleExpanded() => setState(
        () => expanded = !expanded,
      );

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            ///
            /// INFO
            ///
            BalunButton(
              onPressed: toggleExpanded,
              child: Container(
                color: Colors.transparent,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: BalunImage(
                        imageUrl: widget.player.photo ?? BalunImages.placeholderLogo,
                        height: 56,
                        width: 56,
                      ),
                    ),
                    const SizedBox(width: 12),
                    if (widget.player.name != null)
                      Expanded(
                        child: Text(
                          widget.player.name!,
                          style: context.textStyles.leagueTeamsTitle,
                        ),
                      ),
                  ],
                ),
              ),
            ),

            ///
            /// SEASONS
            ///
            AnimatedSize(
              duration: BalunConstants.animationDuration,
              curve: Curves.easeIn,
              child: expanded
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                      child: Wrap(
                        spacing: 24,
                        runSpacing: 16,
                        children: [
                          ///
                          /// AGE
                          ///
                          if (widget.player.age != null)
                            Column(
                              children: [
                                Text(
                                  'Age',
                                  style: context.textStyles.matchInfoSectionTitle,
                                ),
                                Text(
                                  '${widget.player.age}',
                                  style: context.textStyles.matchInfoSectionText,
                                ),
                              ],
                            ),

                          ///
                          /// AGE
                          ///
                          if (widget.player.number != null)
                            Column(
                              children: [
                                Text(
                                  'Number',
                                  style: context.textStyles.matchInfoSectionTitle,
                                ),
                                Text(
                                  '${widget.player.number}',
                                  style: context.textStyles.matchInfoSectionText,
                                ),
                              ],
                            ),

                          ///
                          /// AGE
                          ///
                          if (widget.player.position != null)
                            Column(
                              children: [
                                Text(
                                  'Number',
                                  style: context.textStyles.matchInfoSectionTitle,
                                ),
                                Text(
                                  '${widget.player.position}',
                                  style: context.textStyles.matchInfoSectionText,
                                ),
                              ],
                            ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      );
}
