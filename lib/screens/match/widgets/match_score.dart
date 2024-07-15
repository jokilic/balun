import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/fixtures/goals/goals.dart';
import '../../../models/fixtures/score/score.dart';
import '../../../theme/theme.dart';
import '../../../widgets/balun_button.dart';

class MatchScore extends StatefulWidget {
  final Goals? goals;
  final Score? score;

  const MatchScore({
    required this.goals,
    required this.score,
  });

  @override
  State<MatchScore> createState() => _MatchScoreState();
}

class _MatchScoreState extends State<MatchScore> {
  var isExpanded = false;

  void toggleExpanded() => setState(
        () => isExpanded = !isExpanded,
      );

  @override
  Widget build(BuildContext context) => BalunButton(
        onPressed: toggleExpanded,
        child: Column(
          children: [
            ///
            /// MAIN SCORE
            ///
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: '${widget.goals?.home ?? '-'}'),
                  TextSpan(
                    text: ':',
                    style: context.textStyles.fixturesScore.copyWith(
                      color: context.colors.black.withOpacity(0.2),
                    ),
                  ),
                  TextSpan(text: '${widget.goals?.away ?? '-'}'),
                ],
              ),
              style: context.textStyles.fixturesScore,
              textAlign: TextAlign.center,
            ),

            ///
            /// OTHER SCORES
            ///
            AnimatedSize(
              duration: BalunConstants.animationDuration,
              curve: Curves.easeIn,
              child: isExpanded
                  ? Column(
                      children: [
                        const SizedBox(height: 12),

                        ///
                        /// HALF TIME
                        ///
                        if (widget.score?.halftime?.home != null && widget.score?.halftime?.away != null) ...[
                          Text(
                            'Halftime',
                            style: context.textStyles.otherScores.copyWith(
                              color: context.colors.black.withOpacity(0.4),
                            ),
                          ),
                          Text(
                            '${widget.score?.halftime?.home}:${widget.score?.halftime?.away}',
                            style: context.textStyles.matchGoal,
                          ),
                          const SizedBox(height: 8),
                        ],

                        ///
                        /// FULL TIME
                        ///
                        if (widget.score?.fulltime?.home != null && widget.score?.fulltime?.away != null) ...[
                          Text(
                            'Fulltime',
                            style: context.textStyles.otherScores.copyWith(
                              color: context.colors.black.withOpacity(0.4),
                            ),
                          ),
                          Text(
                            '${widget.score?.fulltime?.home}:${widget.score?.fulltime?.away}',
                            style: context.textStyles.matchGoal,
                          ),
                          const SizedBox(height: 8),
                        ],

                        ///
                        /// EXTRA TIME
                        ///
                        if (widget.score?.extratime?.home != null && widget.score?.extratime?.away != null) ...[
                          Text(
                            'Extratime',
                            style: context.textStyles.otherScores.copyWith(
                              color: context.colors.black.withOpacity(0.4),
                            ),
                          ),
                          Text(
                            '${widget.score?.extratime?.home}:${widget.score?.extratime?.away}',
                            style: context.textStyles.matchGoal,
                          ),
                          const SizedBox(height: 8),
                        ],

                        ///
                        /// PENALTIES
                        ///
                        if (widget.score?.penalty?.home != null && widget.score?.penalty?.away != null) ...[
                          Text(
                            'Penalties',
                            style: context.textStyles.otherScores.copyWith(
                              color: context.colors.black.withOpacity(0.4),
                            ),
                          ),
                          Text(
                            '${widget.score?.penalty?.home}:${widget.score?.penalty?.away}',
                            style: context.textStyles.matchGoal,
                          ),
                          const SizedBox(height: 8),
                        ],
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      );
}
