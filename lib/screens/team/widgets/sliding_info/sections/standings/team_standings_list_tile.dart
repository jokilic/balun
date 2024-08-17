import 'package:flutter/material.dart';

import '../../../../../../constants.dart';
import '../../../../../../models/standings/standing_response.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/standings.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image.dart';
import '../../../../../../widgets/balun_seperator.dart';
import 'team_standing_list_tile.dart';

class TeamStandingsListTile extends StatefulWidget {
  final StandingResponse standing;

  const TeamStandingsListTile({
    required this.standing,
  });

  @override
  State<TeamStandingsListTile> createState() => _TeamStandingsListTileState();
}

class _TeamStandingsListTileState extends State<TeamStandingsListTile> {
  var expanded = false;

  void toggleExpanded() => setState(
        () => expanded = !expanded,
      );

  @override
  Widget build(BuildContext context) {
    final standings = getStandingsList(
      league: widget.standing.league!,
    );

    return Padding(
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
                  BalunImage(
                    imageUrl: widget.standing.league?.logo ?? BalunImages.placeholderLogo,
                    height: 56,
                    width: 56,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.standing.league?.name != null)
                          Text(
                            widget.standing.league!.name!,
                            style: context.textStyles.leagueTeamsTitle,
                          ),
                        if (widget.standing.league?.country != null)
                          Text(
                            widget.standing.league!.country!,
                            style: context.textStyles.leagueTeamsCountry,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          ///
          /// STANDINGS
          ///
          AnimatedSize(
            duration: BalunConstants.animationDuration,
            curve: Curves.easeIn,
            child: expanded
                ? ListView.separated(
                    padding: const EdgeInsets.only(top: 8),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: standings?.length ?? 0,
                    itemBuilder: (_, index) => TeamStandingListTile(
                      standing: standings![index],
                    ),
                    separatorBuilder: (_, __) => const BalunSeperator(),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}