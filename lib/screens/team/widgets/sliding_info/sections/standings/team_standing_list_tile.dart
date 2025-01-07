import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../constants.dart';
import '../../../../../../models/standings/standing/team_standing.dart';
import '../../../../../../theme/icons.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/word_mix.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image/balun_image.dart';
import '../../../../../../widgets/balun_seperator.dart';

class TeamStandingListTile extends StatefulWidget {
  final List<TeamStanding> standings;

  const TeamStandingListTile({
    required this.standings,
  });

  @override
  State<TeamStandingListTile> createState() => _TeamStandingListTileState();
}

class _TeamStandingListTileState extends State<TeamStandingListTile> {
  var expanded = true;

  void toggleExpanded() => setState(
        () => expanded = !expanded,
      );

  @override
  Widget build(BuildContext context) => ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.standings.length,
        itemBuilder: (_, index) {
          final standing = widget.standings[index];

          return BalunButton(
            onPressed: toggleExpanded,
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        '${standing.rank ?? '--'}',
                        style: context.textStyles.matchStandingsSectionText,
                      ),
                      const SizedBox(width: 12),
                      BalunImage(
                        imageUrl: standing.team?.logo ?? BalunIcons.placeholderTeam,
                        height: 32,
                        width: 32,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          mixOrOriginalWords(standing.team?.name) ?? '--',
                          style: context.textStyles.matchStandingsSectionText,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 32),
                      SizedBox(
                        width: 36,
                        child: Text(
                          '${standing.all?.played ?? '--'}',
                          style: context.textStyles.matchStandingsSectionText,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 36,
                        child: Text(
                          '${standing.all?.win ?? '--'}',
                          style: context.textStyles.matchStandingsSectionText,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 36,
                        child: Text(
                          '${standing.points ?? '--'}',
                          style: context.textStyles.matchStandingsSectionText,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  AnimatedSize(
                    duration: BalunConstants.expandDuration,
                    curve: Curves.easeIn,
                    child: expanded
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(60, 16, 8, 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'leagueStandingsForm'.tr(),
                                      style: context.textStyles.matchStandingsSectionText.copyWith(
                                        color: context.colors.black.withValues(alpha: 0.5),
                                      ),
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(width: 8),
                                    if (standing.form != null)
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: standing.form!.split('').map(
                                          (letter) {
                                            final color = switch (letter.toUpperCase()) {
                                              'W' => context.colors.green,
                                              'L' => context.colors.red,
                                              'D' => context.colors.black.withValues(alpha: 0.4),
                                              _ => context.colors.blue,
                                            };

                                            return Container(
                                              alignment: Alignment.center,
                                              width: 32,
                                              margin: const EdgeInsets.symmetric(horizontal: 2),
                                              padding: const EdgeInsets.symmetric(vertical: 2),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(4),
                                                color: color,
                                              ),
                                              child: Text(
                                                letter,
                                                style: context.textStyles.matchStandingsSectionForm,
                                              ),
                                            );
                                          },
                                        ).toList(),
                                      ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'leagueStandingsPointsLong'.tr(),
                                      style: context.textStyles.matchStandingsSectionText.copyWith(
                                        color: context.colors.black.withValues(alpha: 0.5),
                                      ),
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${standing.points ?? '--'}',
                                      style: context.textStyles.matchStandingsSectionText,
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(
                                      'leagueStandingsGoalDifferenceLong'.tr(),
                                      style: context.textStyles.matchStandingsSectionText.copyWith(
                                        color: context.colors.black.withValues(alpha: 0.5),
                                      ),
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${standing.goalsDiff ?? '--'}',
                                      style: context.textStyles.matchStandingsSectionText,
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(
                                      'leagueStandingsPlayedGamesLong'.tr(),
                                      style: context.textStyles.matchStandingsSectionText.copyWith(
                                        color: context.colors.black.withValues(alpha: 0.5),
                                      ),
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${standing.all?.played ?? '--'}',
                                      style: context.textStyles.matchStandingsSectionText,
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(
                                      'leagueStandingsWonGamesLong'.tr(),
                                      style: context.textStyles.matchStandingsSectionText.copyWith(
                                        color: context.colors.black.withValues(alpha: 0.5),
                                      ),
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${standing.all?.win ?? '--'}',
                                      style: context.textStyles.matchStandingsSectionText,
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(
                                      'leagueStandingsDrewGamesLong'.tr(),
                                      style: context.textStyles.matchStandingsSectionText.copyWith(
                                        color: context.colors.black.withValues(alpha: 0.5),
                                      ),
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${standing.all?.draw ?? '--'}',
                                      style: context.textStyles.matchStandingsSectionText,
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(
                                      'leagueStandingsLostGamesLong'.tr(),
                                      style: context.textStyles.matchStandingsSectionText.copyWith(
                                        color: context.colors.black.withValues(alpha: 0.5),
                                      ),
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${standing.all?.lose ?? '--'}',
                                      style: context.textStyles.matchStandingsSectionText,
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(
                                      'leagueStandingsScoredGoalsLong'.tr(),
                                      style: context.textStyles.matchStandingsSectionText.copyWith(
                                        color: context.colors.black.withValues(alpha: 0.5),
                                      ),
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${standing.all?.goals?.goalsFor ?? '--'}',
                                      style: context.textStyles.matchStandingsSectionText,
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(
                                      'leagueStandingsConcededGoalsLong'.tr(),
                                      style: context.textStyles.matchStandingsSectionText.copyWith(
                                        color: context.colors.black.withValues(alpha: 0.5),
                                      ),
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${standing.all?.goals?.goalsAgainst ?? '--'}',
                                      style: context.textStyles.matchStandingsSectionText,
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                if (standing.description != null) ...[
                                  const SizedBox(height: 16),
                                  Text(
                                    mixOrOriginalWords(standing.description) ?? '---',
                                    style: context.textStyles.matchStandingsSectionTextCompact,
                                  ),
                                ],
                                const SizedBox(height: 8),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (_, __) => const BalunSeperator(),
      );
}
