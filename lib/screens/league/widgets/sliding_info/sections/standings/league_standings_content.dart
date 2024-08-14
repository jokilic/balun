import 'package:flutter/material.dart';

import '../../../../../../models/standings/league/league.dart';

class LeagueStandingsContent extends StatelessWidget {
  final League league;

  const LeagueStandingsContent({
    required this.league,
  });

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.green,
        height: 100,
        width: 100,
      );
}
