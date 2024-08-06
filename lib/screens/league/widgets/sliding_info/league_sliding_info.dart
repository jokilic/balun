import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../models/leagues/league_response.dart';
import '../../controllers/league_section_controller.dart';

class LeagueSlidingInfo extends WatchingWidget {
  final LeagueResponse league;
  final ScrollController scrollController;

  const LeagueSlidingInfo({
    required this.league,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final leagueSection = watchIt<LeagueSectionController>(
      instanceName: '${league.league?.id}',
    ).value;

    return const Placeholder();
  }
}
