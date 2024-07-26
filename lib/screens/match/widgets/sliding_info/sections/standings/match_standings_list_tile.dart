import 'package:flutter/material.dart';

import '../../../../../../constants.dart';
import '../../../../../../models/standings/standing/team_standing.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image.dart';

class MatchStandingsListTile extends StatefulWidget {
  final TeamStanding standing;

  const MatchStandingsListTile({
    required this.standing,
  });

  @override
  State<MatchStandingsListTile> createState() => _MatchStandingsListTileState();
}

class _MatchStandingsListTileState extends State<MatchStandingsListTile> {
  var expanded = false;

  void toggleExpanded() => setState(
        () => expanded = !expanded,
      );

  @override
  Widget build(BuildContext context) => BalunButton(
        onPressed: toggleExpanded,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    '${widget.standing.rank ?? '--'}',
                    style: context.textStyles.matchStandingsRank,
                  ),
                  const SizedBox(width: 12),
                  BalunImage(
                    imageUrl: widget.standing.team!.logo!,
                    height: 32,
                    width: 32,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.standing.team?.name ?? '--',
                      style: context.textStyles.matchStandingsRank,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 32),
                  SizedBox(
                    width: 36,
                    child: Text(
                      '${widget.standing.all?.played ?? '--'}',
                      style: context.textStyles.matchStandingsRank,
                      maxLines: 1,
                      textAlign: TextAlign.right,
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 36,
                    child: Text(
                      '${widget.standing.goalsDiff ?? '--'}',
                      style: context.textStyles.matchStandingsRank,
                      maxLines: 1,
                      textAlign: TextAlign.right,
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 36,
                    child: Text(
                      '${widget.standing.points ?? '--'}',
                      style: context.textStyles.matchStandingsRank,
                      maxLines: 1,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              AnimatedSize(
                duration: BalunConstants.animationDuration,
                curve: Curves.easeIn,
                child: expanded
                    ? Container(
                        height: 100,
                        width: 100,
                        color: Colors.indigo,
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      );
}
