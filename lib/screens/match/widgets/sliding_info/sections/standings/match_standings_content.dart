import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../models/standings/standing_response.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/word_mix.dart';
import '../../../../../../widgets/balun_seperator.dart';
import 'match_standings_list_tile.dart';

class MatchStandingsContent extends StatelessWidget {
  final List<StandingResponse> standings;

  const MatchStandingsContent({
    required this.standings,
  });

  @override
  Widget build(BuildContext context) => ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        itemCount: standings.first.league?.standings?.length ?? 0,
        itemBuilder: (_, index) {
          final standing = standings.first.league!.standings![index];

          return Column(
            children: [
              if (standing.first.group != null)
                Text(
                  mixOrOriginalWords(standing.first.group) ?? '---',
                  style: context.textStyles.headlineMd,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 36,
                    child: Text(
                      'leagueStandingsPlayed'.tr(),
                      style: context.textStyles.bodyLgMedium,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 36,
                    child: Text(
                      'leagueStandingsWins'.tr(),
                      style: context.textStyles.bodyLgMedium,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 36,
                    child: Text(
                      'leagueStandingsPoints'.tr(),
                      style: context.textStyles.bodyLgMedium,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: standing.length,
                itemBuilder: (_, index) => MatchStandingsListTile(
                  standing: standing[index],
                ),
                separatorBuilder: (_, __) => const BalunSeperator(),
              ),
              const SizedBox(height: 24),
            ],
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 24),
      );
}
