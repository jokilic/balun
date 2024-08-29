import 'package:flutter/material.dart';

import '../../../../../models/search/search_coaches/search_coach_response.dart';
import '../../../../../routing.dart';
import 'search_coaches_list_tile.dart';

class SearchCoachesSuccess extends StatelessWidget {
  final List<SearchCoachResponse> coaches;

  const SearchCoachesSuccess({
    required this.coaches,
  });

  @override
  Widget build(BuildContext context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: coaches.length,
        itemBuilder: (_, index) {
          final coach = coaches[index];

          return SearchCoachesListTile(
            coach: coach,
            coachPressed: coach.id != null
                ? () => openCoach(
                      context,
                      coachId: coach.id!,
                    )
                : null,
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 4),
      );
}
