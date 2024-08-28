import 'package:flutter/material.dart';

import '../../widgets/balun_error.dart';
import '../../widgets/balun_navigation_bar.dart';

// TODO: Implement this
class SearchScreen extends StatelessWidget {
  const SearchScreen({required super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        bottomNavigationBar: BalunNavigationBar(),
        body: const BalunError(
          error: 'Search is still under construction',
        ),
      );
}
