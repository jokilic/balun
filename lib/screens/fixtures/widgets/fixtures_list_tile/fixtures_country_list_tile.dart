import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../models/fixtures/fixture_response.dart';
import '../../../../models/fixtures/league/league.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/balun_button.dart';
import '../../../../widgets/balun_image.dart';
import 'fixtures_league_list_tile.dart';

class FixturesCountryListTile extends StatefulWidget {
  final League? countryLeague;
  final Map<League, List<FixtureResponse>>? leagues;
  final bool initiallyExpanded;

  const FixturesCountryListTile({
    required this.countryLeague,
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: BalunImage(
                      imageUrl: widget.countryLeague?.flag ?? BalunImages.placeholderLogo,
                      height: 40,
                      width: 40,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    child: Text(
                      widget.countryLeague?.country ?? 'Unknown',
                      style: context.textStyles.fixturesCountry,
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
                    itemCount: widget.leagues?.length ?? 0,
                    itemBuilder: (_, leagueIndex) {
                      final league = widget.leagues?.keys.elementAtOrNull(leagueIndex);
                      final fixtures = widget.leagues?[league];

                      return FixturesLeagueListTile(
                        league: league,
                        fixtures: fixtures,
                        initiallyExpanded: false,
                      );
                    },
                  )
                : const SizedBox.shrink(),
          ),
          const SizedBox(height: 32),
        ],
      );
}
