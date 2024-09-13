import 'package:flutter/material.dart';

import '../../../../../../constants.dart';
import '../../../../../../models/fixtures/fixture_response.dart';
import '../../../../../../routing.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../widgets/balun_button.dart';
import 'league_fixtures_list_tile.dart';

class LeagueFixturesGroup extends StatefulWidget {
  final String round;
  final List<FixtureResponse> fixtures;

  const LeagueFixturesGroup({
    required this.round,
    required this.fixtures,
  });

  @override
  _LeagueFixturesGroupState createState() => _LeagueFixturesGroupState();
}

class _LeagueFixturesGroupState extends State<LeagueFixturesGroup> {
  var expanded = false;

  void toggleExpanded() => setState(
        () => expanded = !expanded,
      );

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            BalunButton(
              onPressed: toggleExpanded,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: context.colors.black.withOpacity(0.075),
                  border: Border.all(
                    color: context.colors.black,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.round,
                      style: context.textStyles.leagueFixturesTitle,
                    ),
                  ],
                ),
              ),
            ),
            AnimatedSize(
              duration: BalunConstants.animationDuration,
              curve: Curves.easeIn,
              child: expanded
                  ? ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      physics: const BouncingScrollPhysics(),
                      itemCount: widget.fixtures.length,
                      itemBuilder: (_, index) {
                        final fixture = widget.fixtures[index];

                        return LeagueFixturesListTile(
                          fixture: fixture,
                          fixturePressed: () => openMatch(
                            context,
                            matchId: fixture.fixture!.id!,
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(height: 24),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      );
}
