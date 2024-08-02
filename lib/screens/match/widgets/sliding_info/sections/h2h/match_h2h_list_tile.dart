import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/fixture_response.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../widgets/balun_button.dart';

class MatchH2HListTile extends StatelessWidget {
  final FixtureResponse fixture;
  final Function() fixturePressed;

  const MatchH2HListTile({
    required this.fixture,
    required this.fixturePressed,
  });

  @override
  Widget build(BuildContext context) => BalunButton(
        onPressed: fixturePressed,
        child: Container(
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.colors.greenish,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Column(
            children: [],
          ),
        ),
      );
}
