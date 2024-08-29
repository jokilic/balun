import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../../../controllers/search_countries_controller.dart';

class SearchCountriesSection extends WatchingWidget {
  @override
  Widget build(BuildContext context) {
    final searchCountriesState = watchIt<SearchCountriesController>(
      instanceName: 'search',
    ).value;

    return const Placeholder(
      color: Colors.yellow,
    );
  }
}
