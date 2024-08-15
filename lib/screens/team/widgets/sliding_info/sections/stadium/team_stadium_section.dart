import 'package:flutter/material.dart';

import '../../../../../../models/teams/venue/venue.dart';

class TeamStadiumSection extends StatelessWidget {
  final Venue? stadium;

  const TeamStadiumSection({
    required this.stadium,
  });

  @override
  Widget build(BuildContext context) => Text(
        stadium?.name ?? 'No name',
      );
}
