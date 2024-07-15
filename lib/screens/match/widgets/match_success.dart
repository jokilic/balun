import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/fixtures/fixture_response.dart';
import '../../../routing.dart';
import '../../../theme/theme.dart';
import '../../../util/string.dart';
import '../../../widgets/balun_button.dart';
import 'match_app_bar.dart';
import 'match_logo.dart';
import 'match_minute.dart';
import 'match_score.dart';

class MatchSuccess extends StatelessWidget {
  final FixtureResponse match;

  const MatchSuccess({
    required this.match,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Stack(
          children: [
            ///
            /// TOP SECTION
            ///
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Column(
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
                                  )
                              : null,
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
                                match.teams?.home?.name ?? 'No name',
                                style: context.textStyles.fixturesName,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ],
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
                              minutes: match.fixture?.status?.elapsed ?? 0,
                            ),
                          ],
                        ),
                      ),

                      ///
                      /// AWAY
                      ///
                      Expanded(
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
                              match.teams?.away?.name ?? 'No name',
                              style: context.textStyles.fixturesName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

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
                                    (event) => Padding(
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
                                              getLastWord(event.player?.name ?? '---'),
                                              style: context.textStyles.matchGoal,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
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

                      ///
                      /// SCORE
                      ///
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            MatchScore(
                              goals: match.goals,
                              score: match.score,
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
            ),

            ///
            /// BOTTOM SECTION
            ///
            Positioned(
              top: 0,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  const IgnorePointer(
                    child: SizedBox(
                      height: 400,
                    ),
                  ),
                  Container(
                    height: 400,
                    width: 200,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 400,
                    width: 200,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 400,
                    width: 200,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
