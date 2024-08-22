import 'package:flutter/material.dart';

import '../../widgets/balun_navigation_bar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({required super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        bottomNavigationBar: BalunNavigationBar(),
        body: Container(
          color: Colors.cyanAccent,
        ),
      );
}
