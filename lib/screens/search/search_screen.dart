import 'package:flutter/material.dart' hide SearchController;

import '../../services/api_service.dart';
import '../../services/logger_service.dart';
import '../../util/dependencies.dart';
import '../../widgets/balun_error.dart';
import '../../widgets/balun_navigation_bar.dart';
import 'controllers/search_controller.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({required super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();

    getIt.registerLazySingleton(
      () => SearchController(
        logger: getIt.get<LoggerService>(),
        api: getIt.get<APIService>(),
      ),
      instanceName: 'search',
    );
  }

  @override
  void dispose() {
    getIt.unregister<SearchController>(
      instanceName: 'search',
    );

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        bottomNavigationBar: BalunNavigationBar(),
        body: const BalunError(
          error: 'Search is still under construction',
        ),
      );
}
