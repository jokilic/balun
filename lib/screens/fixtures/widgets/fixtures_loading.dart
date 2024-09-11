import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../constants.dart';
import 'fixtures_app_bar.dart';
import 'fixtures_list_tile/fixtures_country/fixtures_country_list_tile_loading.dart';

class FixturesLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Animate(
        onPlay: (controller) => controller.loop(
          reverse: true,
          min: 0.6,
        ),
        effects: const [
          FadeEffect(
            curve: Curves.easeIn,
            duration: BalunConstants.shimmerDuration,
          ),
        ],
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 8),
            FixturesAppBar(
              onPressed: () {},
              text: 'Favorite matches',
            ),
            const SizedBox(height: 24),
            ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 2,
              itemBuilder: (_, __) => FixturesCountryListTileLoading(),
              separatorBuilder: (_, __) => const SizedBox(height: 16),
            ),
            const SizedBox(height: 40),
            FixturesAppBar(
              onPressed: () {},
              text: 'All matches',
            ),
            const SizedBox(height: 24),
            ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 8,
              itemBuilder: (_, __) => FixturesCountryListTileLoading(),
              separatorBuilder: (_, __) => const SizedBox(height: 16),
            ),
          ],
        ),
      );
}
