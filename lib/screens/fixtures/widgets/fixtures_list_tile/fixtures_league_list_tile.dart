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
              color: Colors.transparent,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const SizedBox(width: 72),
                  Flexible(
                    child: Text(
                      widget.league?.name ?? 'Unknown',
                      style: context.textStyles.fixturesLeague,
                    ),
                  ),
                  const SizedBox(width: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: BalunImage(
                      imageUrl: widget.league?.logo ?? BalunImages.placeholderLogo,
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
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.fixtures?.length,
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
                  )
                : const SizedBox.shrink(),
          ),
        ],
      );
}
