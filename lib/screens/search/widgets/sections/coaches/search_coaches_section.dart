import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../../../controllers/search_coaches_controller.dart';

class SearchCoachesSection extends WatchingWidget {
  @override
  Widget build(BuildContext context) {
    final searchCoachesState = watchIt<SearchCoachesController>(
      instanceName: 'search',
    ).value;

    return const Placeholder(
      color: Colors.red,
    );
  }
}
