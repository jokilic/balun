import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../constants.dart';
import '../../../../../../models/standings/standing/team_standing.dart';
import '../../../../../../theme/icons.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/word_mix.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image.dart';

class LeagueStandingsListTile extends StatefulWidget {
  final TeamStanding standing;

  const LeagueStandingsListTile({
    required this.standing,
  });

  @override
  State<LeagueStandingsListTile> createState() => _LeagueStandingsListTileState();
}

class _LeagueStandingsListTileState extends State<LeagueStandingsListTile> {
  var expanded = false;

  void toggleExpanded() => setState(
    () => expanded = !expanded,
  );

  @override
  Widget build(BuildContext context) => BalunButton(
    onPressed: toggleExpanded,
    child: Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '${widget.standing.rank ?? '--'}',
                style: context.textStyles.matchStandingsSectionText,
              ),
              const SizedBox(width: 12),
              BalunImage(
                imageUrl: widget.standing.team?.logo ?? BalunIcons.placeholderTeam,
                height: 32,
                width: 32,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  mixOrOriginalWords(widget.standing.team?.name ?? '--') ?? '--',
                  style: context.textStyles.matchStandingsSectionText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 32),
              SizedBox(
                width: 36,
                child: Text(
                  '${widget.standing.all?.played ?? '--'}',
                  style: context.textStyles.matchStandingsSectionText,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 36,
                child: Text(
                  '${widget.standing.all?.win ?? '--'}',
                  style: context.textStyles.matchStandingsSectionText,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 36,
                child: Text(
                  '${widget.standing.points ?? '--'}',
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
                                color: context.colors.primaryForeground.withValues(alpha: 0.5),
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(width: 8),
                            if (widget.standing.form != null)
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: widget.standing.form!.split('').map(
                                  (letter) {
                                    final color = switch (letter.toUpperCase()) {
                                      'W' => context.colors.accentStrong,
                                      'L' => context.colors.danger,
                                      'D' => context.colors.primaryForeground.withValues(alpha: 0.4),
                                      _ => context.colors.info,
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
                                color: context.colors.primaryForeground.withValues(alpha: 0.5),
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${widget.standing.points ?? '--'}',
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
                                color: context.colors.primaryForeground.withValues(alpha: 0.5),
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${widget.standing.goalsDiff ?? '--'}',
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
                                color: context.colors.primaryForeground.withValues(alpha: 0.5),
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${widget.standing.all?.played ?? '--'}',
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
                                color: context.colors.primaryForeground.withValues(alpha: 0.5),
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${widget.standing.all?.win ?? '--'}',
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
                                color: context.colors.primaryForeground.withValues(alpha: 0.5),
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${widget.standing.all?.draw ?? '--'}',
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
                                color: context.colors.primaryForeground.withValues(alpha: 0.5),
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${widget.standing.all?.lose ?? '--'}',
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
                                color: context.colors.primaryForeground.withValues(alpha: 0.5),
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${widget.standing.all?.goals?.goalsFor ?? '--'}',
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
                                color: context.colors.primaryForeground.withValues(alpha: 0.5),
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${widget.standing.all?.goals?.goalsAgainst ?? '--'}',
                              style: context.textStyles.matchStandingsSectionText,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        if (widget.standing.description != null) ...[
                          const SizedBox(height: 16),
                          Text(
                            mixOrOriginalWords(widget.standing.description) ?? '---',
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
}
