import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../models/fixtures/fixture_response.dart';
import '../../../../routing.dart';
import '../../../../theme/theme.dart';
import '../../../../util/string.dart';
import '../../../../widgets/balun_button.dart';
import '../match_app_bar.dart';
import 'match_logo.dart';
import 'match_minute.dart';

class MatchMainInfo extends StatelessWidget {
  final FixtureResponse match;

  const MatchMainInfo({
    required this.match,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ///
            /// BACK & LEAGUE
            ///
            MatchAppBar(
              onPressed: Navigator.of(context).pop,
              league: match.league!,
            ),

            const SizedBox(height: 48),

            ///
            /// LOGOS, TEAM NAMES & MINUTE
            ///
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///
                /// HOME
                ///
                Expanded(
                  child: BalunButton(
                    onPressed: match.teams?.home?.id != null
                        ? () => openTeam(
                              context,
                              teamId: match.teams!.home!.id!,
                              season: match.league?.season ?? DateTime.now().year,
                            )
                        : null,
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          ///
                          /// HOME LOGO
                          ///
                          MatchLogo(
                            logo: match.teams?.home?.logo ?? BalunImages.placeholderLogo,
                          ),

                          const SizedBox(height: 16),

                          ///
                          /// HOME NAME
                          ///
                          Text(
                            match.teams?.home?.name ?? '---',
                            style: context.textStyles.fixturesName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                ///
                /// MINUTE
                ///
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      ///
                      /// MINUTE
                      ///
                      MatchMinute(
                        status: getMatchStatusMinutes(
                          statusShort: match.fixture?.status?.short ?? '?',
                          minutes: match.fixture?.status?.elapsed ?? 0,
                        ),
                      ),
                    ],
                  ),
                ),

                ///
                /// AWAY
                ///
                Expanded(
                  child: BalunButton(
                    onPressed: match.teams?.away?.id != null
                        ? () => openTeam(
                              context,
                              teamId: match.teams!.away!.id!,
                              season: match.league?.season ?? DateTime.now().year,
                            )
                        : null,
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          ///
                          /// AWAY LOGO
                          ///
                          MatchLogo(
                            logo: match.teams?.away?.logo ?? BalunImages.placeholderLogo,
                          ),

                          const SizedBox(height: 16),

                          ///
                          /// AWAY NAME
                          ///
                          Text(
                            match.teams?.away?.name ?? '---',
                            style: context.textStyles.fixturesName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            ///
            /// SCORE & GOALSCORERS
            ///
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///
                /// HOME SCORERS
                ///
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      if (match.events?.isNotEmpty ?? false)
                        ...match.events!
                            .where(
                          (event) => event.team?.id == match.teams?.home?.id && event.type == 'Goal',
                        )
                            .map(
                          (event) {
                            final playerName = getLastWord(event.player?.name ?? '---');

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${event.time?.elapsed}'",
                                    style: context.textStyles.matchGoal.copyWith(
                                      color: context.colors.black.withOpacity(0.4),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      event.detail?.toLowerCase() == 'penalty'
                                          ? '$playerName (P)'
                                          : event.detail?.toLowerCase() == 'own goal'
                                              ? '$playerName (OG)'
                                              : playerName,
                                      style: context.textStyles.matchGoal,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ).toList(),
                    ],
                  ),
                ),

                ///
                /// SCORE
                ///
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: '${match.goals?.home ?? '-'}'),
                            TextSpan(
                              text: ':',
                              style: context.textStyles.fixturesScore.copyWith(
                                color: context.colors.black.withOpacity(0.2),
                              ),
                            ),
                            TextSpan(text: '${match.goals?.away ?? '-'}'),
                          ],
                        ),
                        style: context.textStyles.fixturesScore,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                ///
                /// AWAY SCORERS
                ///
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      if (match.events?.isNotEmpty ?? false)
                        ...match.events!
                            .where(
                              (event) => event.team?.id == match.teams?.away?.id && event.type == 'Goal',
                            )
                            .map(
                              (event) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        getLastWord(event.player?.name ?? '---'),
                                        style: context.textStyles.matchGoal,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "${event.time?.elapsed}'",
                                      style: context.textStyles.matchGoal.copyWith(
                                        color: context.colors.black.withOpacity(0.4),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
