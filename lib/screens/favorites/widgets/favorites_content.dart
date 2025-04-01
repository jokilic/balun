import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../../../models/fixtures/league/league.dart';
import '../../../routing.dart';
import '../../../services/league_storage_service.dart';
import '../../../services/team_storage_service.dart';
import '../../../theme/icons.dart';
import '../../../theme/theme.dart';
import '../../../util/date_time.dart';
import '../../../util/word_mix.dart';
import '../../../widgets/balun_button.dart';
import '../../../widgets/balun_image/balun_image.dart';

class FavoritesContent extends WatchingStatefulWidget {
  final Function() onPressed;
  final Function(int oldIndex, int newIndex) onReorderLeagues;
  final Function(int oldIndex, int newIndex) onReorderTeams;

  const FavoritesContent({
    required this.onPressed,
    required this.onReorderLeagues,
    required this.onReorderTeams,
  });

  @override
  State<FavoritesContent> createState() => _FavoritesContentState();
}

class _FavoritesContentState extends State<FavoritesContent> {
  late final ScrollController scrollController;
  var isDragging = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void onPointerMove({
    required double dy,
    required double screenHeight,
  }) {
    if (!isDragging) {
      return;
    }

    if (!scrollController.hasClients) {
      return;
    }

    const scrollSpeed = 10;

    /// User dragged up
    if (dy < 200) {
      final currentOffset = scrollController.offset;
      final newOffset = (currentOffset - scrollSpeed).clamp(
        0.0,
        scrollController.position.maxScrollExtent,
      );

      WidgetsBinding.instance.addPostFrameCallback(
        (_) => scrollController.jumpTo(newOffset),
      );
    }

    /// User dragged down
    if (dy > (screenHeight - 200)) {
      final currentOffset = scrollController.offset;
      final newOffset = (currentOffset + scrollSpeed).clamp(
        0.0,
        scrollController.position.maxScrollExtent,
      );

      WidgetsBinding.instance.addPostFrameCallback(
        (_) => scrollController.jumpTo(newOffset),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoritedLeagues = watchIt<LeagueStorageService>()
        .value
        .map(
          (league) => League(
            id: league.id,
            name: league.name,
            logo: league.logo,
          ),
        )
        .toList();

    final favoritedTeams = watchIt<TeamStorageService>().value;

    return Listener(
      onPointerMove: (event) => onPointerMove(
        dy: event.position.dy,
        screenHeight: MediaQuery.sizeOf(context).height,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///
            /// TEXT
            ///
            Text(
              // TODO: Localize
              'Here you can see your favorited leagues & teams.',
              style: context.textStyles.dialogText,
            ),
            const SizedBox(height: 12),
            Text(
              // TODO: Localize
              'Ones which are favorited will be more prominently displayed in the app, so you can see them more clearly and without distractions.',
              style: context.textStyles.dialogText,
            ),
            const SizedBox(height: 12),
            Text(
              // TODO: Localize
              'You can favorite others by opening relevant league / team and pressing the star icon.',
              style: context.textStyles.dialogText,
            ),
            const SizedBox(height: 24),

            ///
            /// LEAGUES
            ///
            Text(
              'fixturesFavoriteDialogLeagues'.tr(),
              style: context.textStyles.dialogSubtitle,
            ),
            const SizedBox(height: 12),
            if (favoritedLeagues.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'fixturesFavoriteDialogNoLeagues'.tr(),
                  style: context.textStyles.dialogText,
                ),
              )
            else
              SizedBox(
                height: (40 * favoritedLeagues.length).toDouble(),
                width: double.maxFinite,
                child: ReorderableListView.builder(
                  proxyDecorator: (child, _, __) => ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Material(
                      color: context.colors.white.withValues(alpha: 0.4),
                      child: child,
                    ),
                  ),
                  onReorderStart: (_) => isDragging = true,
                  onReorderEnd: (_) => isDragging = false,
                  onReorder: (oldIndex, newIndex) {
                    if (newIndex > oldIndex) {
                      newIndex--;
                    }

                    widget.onReorderLeagues(oldIndex, newIndex);
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: favoritedLeagues.length,
                  itemBuilder: (_, index) {
                    final league = favoritedLeagues[index];

                    return BalunButton(
                      key: ValueKey(league),
                      onPressed: league.id != null
                          ? () => openLeague(
                                context,
                                leagueId: league.id!,
                                season: league.season ?? getCurrentSeasonYear().toString(),
                              )
                          : null,
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        child: Row(
                          children: [
                            BalunImage(
                              imageUrl: league.logo ?? BalunIcons.placeholderLeague,
                              height: 32,
                              width: 32,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                mixOrOriginalWords(league.name) ?? '---',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.textStyles.dialogText.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

            const SizedBox(height: 24),

            ///
            /// TEAMS
            ///
            Text(
              'fixturesFavoriteDialogTeams'.tr(),
              style: context.textStyles.dialogSubtitle,
            ),
            const SizedBox(height: 12),
            if (favoritedTeams.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'fixturesFavoriteDialogNoTeams'.tr(),
                  style: context.textStyles.dialogText,
                ),
              )
            else
              SizedBox(
                height: (40 * favoritedTeams.length).toDouble(),
                width: double.maxFinite,
                child: ReorderableListView.builder(
                  proxyDecorator: (child, _, __) => ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Material(
                      color: context.colors.white.withValues(alpha: 0.4),
                      child: child,
                    ),
                  ),
                  onReorderStart: (_) => isDragging = true,
                  onReorderEnd: (_) => isDragging = false,
                  onReorder: (oldIndex, newIndex) {
                    if (newIndex > oldIndex) {
                      newIndex--;
                    }

                    widget.onReorderTeams(oldIndex, newIndex);
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: favoritedTeams.length,
                  itemBuilder: (_, index) {
                    final team = favoritedTeams[index];

                    return BalunButton(
                      key: ValueKey(team),
                      onPressed: team.id != null
                          ? () => openTeam(
                                context,
                                teamId: team.id!,
                                season: getCurrentSeasonYear().toString(),
                              )
                          : null,
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        child: Row(
                          children: [
                            BalunImage(
                              imageUrl: team.logo ?? BalunIcons.placeholderLeague,
                              height: 32,
                              width: 32,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                mixOrOriginalWords(team.name) ?? '---',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.textStyles.dialogText.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
