import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../../../controllers/search_leagues_controller.dart';

class SearchLeaguesSection extends WatchingWidget {
  @override
  Widget build(BuildContext context) {
    final searchLeaguesState = watchIt<SearchLeaguesController>(
      instanceName: 'search',
    ).value;

    return const Placeholder(
      color: Colors.blue,
    );
  }
}
