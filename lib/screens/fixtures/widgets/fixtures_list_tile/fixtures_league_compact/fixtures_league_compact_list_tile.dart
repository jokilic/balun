import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../constants.dart';
import '../../../../../models/fixtures/fixture_response.dart';
import '../../../../../models/fixtures/league/league.dart';
import '../../../../../routing.dart';
import '../../../../../theme/icons.dart';
import '../../../../../theme/theme.dart';
import '../../../../../util/string.dart';
import '../../../../../widgets/balun_button.dart';
import '../../../../../widgets/balun_image.dart';
import '../fixtures/fixtures_compact_list_tile.dart';

class FixturesLeagueCompactListTile extends StatefulWidget {
  final League? league;
  final List<FixtureResponse>? fixtures;
  final bool initiallyExpanded;
  final bool hasLiveFixturesLeague;

  const FixturesLeagueCompactListTile({
    required this.league,
    required this.fixtures,
    required this.hasLiveFixturesLeague,
    this.initiallyExpanded = false,
  });

  @override
  State<FixturesLeagueCompactListTile> createState() => _FixturesLeagueCompactListTileState();
}

class _FixturesLeagueCompactListTileState extends State<FixturesLeagueCompactListTile> {
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
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: context.colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    height: 28,
                    width: 28,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BalunImage(
                          imageUrl: widget.league?.logo ?? BalunIcons.placeholderLeague,
                          height: 28,
                          width: 28,
                        ),
                        const SizedBox(width: 12),
                        Flexible(
                          child: Text(
                            widget.league?.name ?? '---',
                            style: context.textStyles.fixturesLeague,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
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
                          color: widget.hasLiveFixturesLeague ? context.colors.red : Colors.transparent,
                          border: Border.all(
                            color: widget.hasLiveFixturesLeague ? context.colors.black : Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ),
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

                      return FixturesCompactListTile(
                        fixture: fixture,
                        scoreText: getCompactFixtureText(
                          statusShort: fixture.fixture?.status?.short ?? '--',
                          minutes: fixture.fixture?.status?.elapsed ?? 0,
                          timestamp: fixture.fixture?.timestamp,
                          homeGoals: fixture.goals?.home,
                          awayGoals: fixture.goals?.away,
                          context: context,
                        ),
                        fixturePlaying: matchCompactIsPlaying(
                          statusShort: fixture.fixture?.status?.short ?? '--',
                        ),
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
