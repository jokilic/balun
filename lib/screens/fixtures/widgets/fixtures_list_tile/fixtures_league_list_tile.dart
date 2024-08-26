import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../models/fixtures/fixture_response.dart';
import '../../../../models/fixtures/league/league.dart';
import '../../../../routing.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/balun_button.dart';
import '../../../../widgets/balun_image.dart';
import 'fixtures_list_tile.dart';

class FixturesLeagueListTile extends StatefulWidget {
  final League? league;
  final List<FixtureResponse>? fixtures;
  final bool initiallyExpanded;

  const FixturesLeagueListTile({
    required this.league,
    required this.fixtures,
    required this.initiallyExpanded,
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
                color: context.colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 56),
                  Expanded(
                    child: Text(
                      widget.league?.name ?? 'Unknown',
                      style: context.textStyles.fixturesLeague,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: BalunImage(
                      imageUrl: widget.league?.logo ?? BalunImages.placeholderIcon,
                      height: 40,
                      width: 40,
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
                    padding: const EdgeInsets.symmetric(vertical: 8),
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
