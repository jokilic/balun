import 'package:flutter/material.dart';

import '../../../../../../models/coaches/coach_response.dart';
import '../../../../../../widgets/balun_seperator.dart';
import 'team_coaches_list_tile.dart';

class TeamCoachesContent extends StatelessWidget {
  final List<CoachResponse>? coaches;

  const TeamCoachesContent({
    required this.coaches,
  });

  @override
  Widget build(BuildContext context) => ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: coaches?.length ?? 0,
        itemBuilder: (_, index) => TeamCoachesListTile(
          coach: coaches![index],
        ),
        separatorBuilder: (_, __) => const BalunSeperator(),
      );
}
