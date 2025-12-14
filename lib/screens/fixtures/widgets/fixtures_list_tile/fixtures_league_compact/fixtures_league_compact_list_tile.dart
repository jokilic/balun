import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../constants.dart';
import '../../../../../models/fixtures/fixture_response.dart';
import '../../../../../models/fixtures/league/league.dart';
import '../../../../../models/matches/favorite_match.dart';
import '../../../../../routing.dart';
import '../../../../../theme/icons.dart';
import '../../../../../theme/theme.dart';
import '../../../../../util/string.dart';
import '../../../../../util/word_mix.dart';
import '../../../../../widgets/balun_button.dart';
import '../../../../../widgets/balun_image.dart';
import '../fixtures/fixtures_compact_list_tile.dart';

class FixturesLeagueCompactListTile extends StatefulWidget {
  final Function()? onPressed;
  final Function(FixtureResponse fixture) onFixtureLongPressed;
  final League? league;
  final List<FixtureResponse>? fixtures;
  final bool initiallyExpanded;
  final bool hasLiveFixturesLeague;
  final List<FavoriteMatch> favoritedMatches;

  const FixturesLeagueCompactListTile({
    required this.onPressed,
    required this.onFixtureLongPressed,
    required this.league,
    required this.fixtures,
    required this.hasLiveFixturesLeague,
    required this.favoritedMatches,
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
        onPressed: widget.onPressed,
        onLongPressed: toggleExpanded,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: context.colors.fixtureListTileBackground,
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
                    if (widget.league?.logo != null)
                      BalunImage(
                        imageUrl: widget.league!.logo!,
                        height: 28,
                        width: 28,
                      )
                    else
                      BalunImage(
                        imageUrl: BalunIcons.placeholderMatch,
                        height: 24,
                        width: 24,
                        color: context.colors.primaryForeground,
                        radius: 0,
                      ),
                    const SizedBox(width: 12),
                    Flexible(
                      child: Text(
                        mixOrOriginalWords(widget.league?.name) ?? '---',
                        style: context.textStyles.bodyLgBold,
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
                      color: widget.hasLiveFixturesLeague ? context.colors.danger : Colors.transparent,
                      border: Border.all(
                        color: widget.hasLiveFixturesLeague ? context.colors.primaryForeground : Colors.transparent,
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
        duration: BalunConstants.expandDuration,
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
                      extra: fixture.fixture?.status?.extra,
                      timestamp: fixture.fixture?.timestamp,
                      homeGoals: fixture.goals?.home,
                      awayGoals: fixture.goals?.away,
                      context: context,
                    ),
                    fixturePlaying: isMatchPlaying(
                      statusShort: fixture.fixture?.status?.short ?? '--',
                    ),
                    onFixturePressed: fixture.fixture?.id != null
                        ? () {
                            HapticFeedback.lightImpact();
                            openMatch(
                              context,
                              matchId: fixture.fixture!.id!,
                            );
                          }
                        : null,
                    onFixtureLongPressed: () => widget.onFixtureLongPressed(fixture),
                    isFavorited: widget.favoritedMatches.any(
                      (element) => element.matchId == fixture.fixture?.id,
                    ),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 8),
              )
            : const SizedBox.shrink(),
      ),
    ],
  );
}
