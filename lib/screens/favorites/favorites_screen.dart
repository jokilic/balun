import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../constants.dart';
import '../../services/league_storage_service.dart';
import '../../services/team_storage_service.dart';
import '../../util/dependencies.dart';
import 'widgets/favorites_app_bar.dart';
import 'widgets/favorites_content.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({
    required super.key,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Animate(
        effects: const [
          FadeEffect(
            curve: Curves.easeIn,
            duration: BalunConstants.longAnimationDuration,
          ),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),

            ///
            /// APP BAR
            ///
            FavoritesAppBar(
              onPressed: Navigator.of(context).pop,
            ),
            const SizedBox(height: 8),

            ///
            /// CONTENT
            ///
            Expanded(
              child: Animate(
                effects: const [
                  FadeEffect(
                    curve: Curves.easeIn,
                    duration: BalunConstants.animationDuration,
                  ),
                ],
                child: FavoritesContent(
                  onPressed: Navigator.of(context).pop,
                  onReorderLeagues: getIt.get<LeagueStorageService>().reorderLeagues,
                  onReorderTeams: getIt.get<TeamStorageService>().reorderTeams,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
