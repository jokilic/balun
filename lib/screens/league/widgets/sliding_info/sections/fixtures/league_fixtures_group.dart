import 'package:flutter/material.dart';

import '../../../../../../constants.dart';
import '../../../../../../models/fixtures/fixture_response.dart';
import '../../../../../../routing.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/string.dart';
import '../../../../../../util/word_mix.dart';
import '../../../../../../widgets/balun_button.dart';
import 'league_fixtures_list_tile.dart';

class LeagueFixturesGroup extends StatefulWidget {
  final String round;
  final List<FixtureResponse> fixtures;
  final bool initiallyExpanded;

  const LeagueFixturesGroup({
    required this.round,
    required this.fixtures,
    this.initiallyExpanded = false,
  });

  @override
  _LeagueFixturesGroupState createState() => _LeagueFixturesGroupState();
}

class _LeagueFixturesGroupState extends State<LeagueFixturesGroup> {
  late var expanded = widget.initiallyExpanded;

  void toggleExpanded() => setState(
        () => expanded = !expanded,
      );

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            BalunButton(
              onPressed: toggleExpanded,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: context.colors.black,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      mixOrOriginalWords(widget.round) ?? '---',
                      style: context.textStyles.leagueFixturesTitle,
                    ),
                  ],
                ),
              ),
            ),
            AnimatedSize(
              duration: BalunConstants.expandDuration,
              curve: Curves.easeIn,
              child: expanded
                  ? ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      physics: const BouncingScrollPhysics(),
                      itemCount: widget.fixtures.length,
                      itemBuilder: (_, index) {
                        final fixture = widget.fixtures[index];

                        return LeagueFixturesListTile(
                          fixture: fixture,
                          fixturePlaying: isMatchPlaying(
                            statusShort: fixture.fixture?.status?.short ?? '--',
                          ),
                          fixturePressed: () => openMatch(
                            context,
                            matchId: fixture.fixture!.id!,
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      );
}
