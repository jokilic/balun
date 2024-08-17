import 'package:flutter/material.dart';

import '../../../../../../constants.dart';
import '../../../../../../models/coaches/coach_response.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image.dart';
import 'team_coach_career_list_tile.dart';

class TeamCoachesListTile extends StatefulWidget {
  final CoachResponse coach;

  const TeamCoachesListTile({
    required this.coach,
  });

  @override
  State<TeamCoachesListTile> createState() => _TeamCoachesListTileState();
}

class _TeamCoachesListTileState extends State<TeamCoachesListTile> {
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
                    BalunImage(
                      imageUrl: widget.coach.photo ?? BalunImages.placeholderLogo,
                      height: 56,
                      width: 56,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.coach.name != null)
                            Text(
                              widget.coach.name!,
                              style: context.textStyles.leagueTeamsTitle,
                            ),
                          if (widget.coach.age != null)
                            Text(
                              'Age: ${widget.coach.age!}',
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
            /// CAREER
            ///
            if (widget.coach.career?.isNotEmpty ?? false)
              AnimatedSize(
                duration: BalunConstants.animationDuration,
                curve: Curves.easeIn,
                child: expanded
                    ? Padding(
                        padding: const EdgeInsets.only(top: 28, bottom: 8),
                        child: Column(
                          children: widget.coach.career!
                              .map(
                                (careerSingle) => TeamCoachCareerListTile(
                                  career: careerSingle,
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