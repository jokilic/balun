import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../models/fixtures/fixture_response.dart';
import '../../../../routing.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/balun_button.dart';
import 'fixtures_list_tile.dart';

class FixturesLeagueListTile extends StatefulWidget {
  final String? leagueName;
  final List<FixtureResponse>? fixtures;

  const FixturesLeagueListTile({
    required this.leagueName,
    required this.fixtures,
  });

  @override
  State<FixturesLeagueListTile> createState() => _FixturesLeagueListTileState();
}

class _FixturesLeagueListTileState extends State<FixturesLeagueListTile> {
  late var expanded = false;

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
                  Expanded(
                    child: Text(
                      widget.leagueName ?? 'Unknown',
                      style: context.textStyles.fixturesLeague,
                      textAlign: TextAlign.center,
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
          if (expanded) const SizedBox(height: 16),
        ],
      );
}
