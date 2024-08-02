import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/fixture_response.dart';
import '../../../../../../widgets/balun_seperator.dart';

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

          return Container(
            height: 40,
            width: 40,
            color: Colors.orange,
            child: Text(
              fixture.teams?.home?.name ?? 'No',
              style: const TextStyle(
                fontSize: 28,
                color: Colors.white,
              ),
            ),
          );
        },
        separatorBuilder: (_, __) => const BalunSeperator(),
      );
}
