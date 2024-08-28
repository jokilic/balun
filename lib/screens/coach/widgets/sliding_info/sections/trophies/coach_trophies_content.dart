import 'package:flutter/material.dart';

import '../../../../../../models/trophies/trophy_response.dart';
import '../../../../../../widgets/balun_seperator.dart';
import 'coach_trophies_list_tile.dart';

class CoachTrophiesContent extends StatelessWidget {
  final List<TrophyResponse>? trophies;

  const CoachTrophiesContent({
    required this.trophies,
  });

  @override
  Widget build(BuildContext context) => ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: trophies?.length ?? 0,
        itemBuilder: (_, index) => CoachTrophiesListTile(
          trophy: trophies![index],
        ),
        separatorBuilder: (_, __) => const BalunSeperator(),
      );
}
