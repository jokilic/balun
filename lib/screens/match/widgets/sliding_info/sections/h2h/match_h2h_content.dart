import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/fixture_response.dart';
import '../../../../../../routing.dart';
import '../../../../../../widgets/balun_seperator.dart';
import 'match_h2h_list_tile.dart';

class MatchHead2HeadContent extends StatelessWidget {
  final List<FixtureResponse>? fixtures;

  const MatchHead2HeadContent({
    required this.fixtures,
  });

  @override
  Widget build(BuildContext context) => ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        physics: const BouncingScrollPhysics(),
        itemCount: fixtures?.length ?? 0,
        itemBuilder: (_, index) {
          final fixture = fixtures![index];

          return MatchH2HListTile(
            fixture: fixture,
            fixturePressed: () => openMatch(
              context,
              matchId: fixture.fixture!.id!,
            ),
          );
        },
        separatorBuilder: (_, __) => const BalunSeperator(),
      );
}
