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
  Widget build(BuildContext context) => Column(
        children: [
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: fixtures.length,
              itemBuilder: (_, index) {
                final fixture = fixtures[index];

                return FixturesListTile(
                  fixture: fixture,
                  fixturePressed: fixture.fixture?.id != null
                      ? () => openMatch(
                            context,
                            matchId: fixture.fixture!.id!,
                          )
                      : null,
                );
              },
            ),
          ),
        ],
      );
}
