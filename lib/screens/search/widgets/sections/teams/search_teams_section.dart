import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../../../controllers/search_teams_controller.dart';

class SearchTeamsSection extends WatchingWidget {
  @override
  Widget build(BuildContext context) {
    final searchTeamsState = watchIt<SearchTeamsController>(
      instanceName: 'search',
    ).value;

    return const Placeholder(
      color: Colors.green,
    );
  }
}
