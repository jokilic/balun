import 'package:flutter/material.dart';

import '../../../models/fixtures/fixture_response.dart';
import '../../../routing.dart';
import 'fixtures_list_tile/fixtures_list_tile.dart';

class FixturesSuccess extends StatelessWidget {
  final List<FixtureResponse> fixtures;

  const FixturesSuccess({
    required this.fixtures,
  });

  @override
  Widget build(BuildContext context) => ListView.builder(
        padding: EdgeInsets.only(
          top: MediaQuery.paddingOf(context).top,
          bottom: MediaQuery.paddingOf(context).bottom,
        ),
        physics: const BouncingScrollPhysics(),
        itemCount: fixtures.length,
        itemBuilder: (_, index) {
          final fixture = fixtures[index];

          return FixturesListTile(
            fixture: fixture,
            fixturePressed: () => openMatch(
              context,
              matchId: fixture.fixture!.id!,
            ),
          );
        },
      );
}
