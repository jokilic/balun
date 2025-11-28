import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../constants.dart';
import '../../../../../models/fixtures/fixture_response.dart';
import '../../../../../models/fixtures/league/league.dart';
import '../../../../../theme/icons.dart';
import '../../../../../theme/theme.dart';
import '../../../../../util/fixtures.dart';
import '../../../../../util/string.dart';
import '../../../../../util/word_mix.dart';
import '../../../../../widgets/balun_button.dart';
import '../../../../../widgets/balun_image.dart';
import '../fixtures_league/fixtures_league_list_tile.dart';

class FixturesCountryListTile extends StatefulWidget {
  final Function(League? league) onLongPressedListTile;
  final League? countryLeague;
  final Map<League, List<FixtureResponse>>? leagues;
  final bool initiallyExpanded;
  final bool hasLiveFixturesCountry;

  const FixturesCountryListTile({
    required this.onLongPressedListTile,
    required this.countryLeague,
    required this.leagues,
    required this.hasLiveFixturesCountry,
    this.initiallyExpanded = false,
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
          decoration: BoxDecoration(
            color: context.colors.fixtureListTileBackground,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: widget.countryLeague?.flag != null
                    ? BalunImage(
                        imageUrl: widget.countryLeague!.flag!,
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        padding: const EdgeInsets.all(8),
                        color: context.colors.primaryBackground,
                        child: const BalunImage(
                          imageUrl: BalunIcons.placeholderCountry,
                          height: 28,
                          width: 28,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  widget.countryLeague?.country != null
                      ? mixOrOriginalWords(
                              getCountryName(
                                country: widget.countryLeague!.country!,
                              ),
                            ) ??
                            '---'
                      : '---',
                  style: context.textStyles.titleMdBold,
                ),
              ),
              if (widget.hasLiveFixturesCountry) ...[
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
                        color: context.colors.danger,
                        border: Border.all(
                          color: context.colors.primaryForeground,
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
      /// LEAGUES
      ///
      AnimatedSize(
        duration: BalunConstants.expandDuration,
        curve: Curves.easeIn,
        child: expanded
            ? ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 12),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.leagues?.length ?? 0,
                itemBuilder: (_, leagueIndex) {
                  final league = widget.leagues?.keys.elementAtOrNull(leagueIndex);
                  final fixtures = widget.leagues?[league];

                  return FixturesLeagueListTile(
                    onLongPressed: () => widget.onLongPressedListTile(league),
                    league: league,
                    fixtures: fixtures,
                    initiallyExpanded: widget.initiallyExpanded,
                    hasLiveFixturesLeague: hasLiveFixturesLeague(
                      fixtures: fixtures,
                    ),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 12),
              )
            : const SizedBox.shrink(),
      ),
    ],
  );
}
