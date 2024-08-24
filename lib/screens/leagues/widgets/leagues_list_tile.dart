import 'package:flutter/material.dart';

import '../../../../../../constants.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image.dart';
import '../../../models/leagues/league_response.dart';

class LeaguesListTile extends StatelessWidget {
  final LeagueResponse league;
  final Function()? leaguePressed;

  const LeaguesListTile({
    required this.league,
    required this.leaguePressed,
  });

  @override
  Widget build(BuildContext context) => BalunButton(
        onPressed: leaguePressed,
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: BalunImage(
                  imageUrl: league.league?.logo ?? BalunImages.placeholderLogo,
                  height: 56,
                  width: 56,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (league.league?.name != null)
                      Text(
                        league.league!.name!,
                        style: context.textStyles.countriesName,
                      ),
                    if (league.league?.type != null)
                      Text(
                        league.league!.type!,
                        style: context.textStyles.countriesName,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}