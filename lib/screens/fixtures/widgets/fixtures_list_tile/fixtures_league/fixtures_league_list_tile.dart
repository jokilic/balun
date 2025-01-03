import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../constants.dart';
import '../../../../../models/fixtures/fixture_response.dart';
import '../../../../../models/fixtures/league/league.dart';
import '../../../../../routing.dart';
import '../../../../../theme/icons.dart';
import '../../../../../theme/theme.dart';
import '../../../../../util/word_mix.dart';
import '../../../../../widgets/balun_button.dart';
import '../../../../../widgets/balun_image.dart';
import '../fixtures/fixtures_list_tile.dart';

class FixturesLeagueListTile extends StatefulWidget {
  final League? league;
  final List<FixtureResponse>? fixtures;
  final bool initiallyExpanded;
  final bool hasLiveFixturesLeague;

  const FixturesLeagueListTile({
    required this.league,
    required this.fixtures,
    required this.hasLiveFixturesLeague,
    this.initiallyExpanded = false,
  });

  @override
  State<FixturesLeagueListTile> createState() => _FixturesLeagueListTileState();
}

class _FixturesLeagueListTileState extends State<FixturesLeagueListTile> {
  late var expanded = widget.initiallyExpanded;

  void toggleExpanded() => setState(
        () => expanded = !expanded,
      );

  @override
  Widget build(BuildContext context) => Column(
        children: [
          ///
          /// LEAGUE TITLE
          ///
          BalunButton(
            onPressed: toggleExpanded,
            child: Container(
              decoration: BoxDecoration(
                color: context.colors.white.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.fromLTRB(32, 12, 16, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BalunImage(
                    imageUrl: widget.league?.logo ?? BalunIcons.placeholderLeague,
                    height: 32,
                    width: 32,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      mixOrOriginalWords(widget.league?.name) ?? '---',
                      style: context.textStyles.fixturesLeague,
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (widget.hasLiveFixturesLeague) ...[
                    const SizedBox(width: 16),
                    Container(
                      height: 28,
                      width: 28,
                      padding: const EdgeInsets.all(7),
                      child: Animate(
                        onPlay: (controller) => controller.loop(
                          reverse: true,
                          min: 0.6,
                        ),
                        effects: const [
                          FadeEffect(
                            curve: Curves.easeIn,
                            duration: BalunConstants.shimmerDuration,
                          ),
                        ],
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.colors.red,
                            border: Border.all(
                              color: context.colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          ///
          /// FIXTURES
          ///
          AnimatedSize(
            duration: BalunConstants.animationDuration,
            curve: Curves.easeIn,
            child: expanded
                ? ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.fixtures?.length ?? 0,
                    itemBuilder: (_, fixtureIndex) {
                      final fixture = widget.fixtures![fixtureIndex];

                      return FixturesListTile(
                        fixture: fixture,
                        fixturePressed: fixture.fixture?.id != null
                            ? () => openMatch(
                                  context,
                                  matchId: fixture.fixture!.id!,
                                )
                            : null,
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      );
}
