import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../models/fixtures/fixture_response.dart';
import '../../../../routing.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/balun_button.dart';
import '../fixtures_list_tile/fixtures_list_tile.dart';

class FixturesCountryListTile extends StatefulWidget {
  final String? country;
  final Map<String, List<FixtureResponse>>? leagues;
  final bool initiallyExpanded;

  const FixturesCountryListTile({
    required this.country,
    required this.leagues,
    required this.initiallyExpanded,
  });

  @override
  State<FixturesCountryListTile> createState() => _FixturesCountryListTileState();
}

class _FixturesCountryListTileState extends State<FixturesCountryListTile> {
  late var expanded = widget.initiallyExpanded;

  void toggleExpanded() => setState(
        () => expanded = !expanded,
      );

  @override
  Widget build(BuildContext context) => Column(
        children: [
          ///
          /// COUNTRY TITLE
          ///
          BalunButton(
            onPressed: toggleExpanded,
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.country ?? 'Unknown',
                      style: context.textStyles.fixturesCountry,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),

          ///
          /// LEAGUES
          ///
          AnimatedSize(
            duration: BalunConstants.animationDuration,
            curve: Curves.easeIn,
            child: expanded
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.leagues?.length,
                    itemBuilder: (_, leagueIndex) {
                      final leagueName = widget.leagues?.keys.elementAtOrNull(leagueIndex);
                      final fixtures = widget.leagues?[leagueName];

                      return Column(
                        children: [
                          ///
                          /// LEAGUE TITLE
                          ///
                          if (leagueName != null)
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                leagueName,
                                style: context.textStyles.fixturesLeague,
                                textAlign: TextAlign.center,
                              ),
                            ),

                          ///
                          /// FIXTURES
                          ///
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: fixtures?.length,
                            itemBuilder: (_, fixtureIndex) {
                              final fixture = fixtures![fixtureIndex];

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
                          ),
                        ],
                      );
                    },
                  )
                : const SizedBox.shrink(),
          ),
          if (expanded) const SizedBox(height: 16),
        ],
      );
}
