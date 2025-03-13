import 'package:flutter/material.dart';

import '../../../../../../constants.dart';
import '../../../../../../models/leagues/league_response.dart';
import '../../../../../../routing.dart';
import '../../../../../../theme/icons.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/date_time.dart';
import '../../../../../../util/string.dart';
import '../../../../../../util/word_mix.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image/balun_image.dart';

class TeamLeaguesListTile extends StatefulWidget {
  final LeagueResponse league;

  const TeamLeaguesListTile({
    required this.league,
  });

  @override
  State<TeamLeaguesListTile> createState() => _TeamLeaguesListTileState();
}

class _TeamLeaguesListTileState extends State<TeamLeaguesListTile> {
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
                      imageUrl: widget.league.league?.logo ?? BalunIcons.placeholderLeague,
                      height: 48,
                      width: 48,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.league.league?.name != null)
                            Text(
                              mixOrOriginalWords(widget.league.league!.name) ?? '---',
                              style: context.textStyles.leagueTeamsTitle,
                            ),
                          if (widget.league.country?.name != null)
                            Text(
                              mixOrOriginalWords(
                                    getCountryName(
                                      country: widget.league.country!.name!,
                                    ),
                                  ) ??
                                  '---',
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
            /// SEASONS
            ///
            if (widget.league.seasons?.isNotEmpty ?? false)
              AnimatedSize(
                duration: BalunConstants.expandDuration,
                curve: Curves.easeIn,
                child: expanded
                    ? Padding(
                        padding: const EdgeInsets.only(top: 28, bottom: 8),
                        child: Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: widget.league.seasons!.reversed
                              .map(
                                (season) => BalunButton(
                                  onPressed: widget.league.league?.id != null
                                      ? () => openLeague(
                                            context,
                                            leagueId: widget.league.league!.id!,
                                            season: (season.year ?? getCurrentSeasonYear()).toString(),
                                          )
                                      : null,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: context.colors.black,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      '${season.year}',
                                      style: context.textStyles.teamLeaguesSeason,
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
