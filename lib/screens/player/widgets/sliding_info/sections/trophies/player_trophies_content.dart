import 'package:flutter/material.dart';

import '../../../../../../models/trophies/trophy_response.dart';
import '../../../../../../widgets/balun_seperator.dart';
import 'player_trophies_list_tile.dart';

class PlayerTrophiesContent extends StatelessWidget {
  final List<TrophyResponse>? trophies;

  const PlayerTrophiesContent({
    required this.trophies,
  });

  @override
  Widget build(BuildContext context) => ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: trophies?.length ?? 0,
        itemBuilder: (_, index) => PlayerTrophiesListTile(
          trophy: trophies![index],
        ),
        separatorBuilder: (_, __) => const BalunSeperator(),
      );
}
