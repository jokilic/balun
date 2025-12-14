import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:watch_it/watch_it.dart';

import '../../../models/fixtures/league/league.dart';
import '../../../routing.dart';
import '../../../services/league_storage_service.dart';
import '../../../services/match_storage_service.dart';
import '../../../services/team_storage_service.dart';
import '../../../theme/icons.dart';
import '../../../theme/theme.dart';
import '../../../util/date_time.dart';
import '../../../util/word_mix.dart';
import '../../../widgets/balun_button.dart';
import '../../../widgets/balun_image.dart';

class FavoritesContent extends WatchingStatefulWidget {
  final Function() onPressed;
  final Function(int oldIndex, int newIndex) onReorderLeagues;
  final Function(int oldIndex, int newIndex) onReorderTeams;
  final Function(int oldIndex, int newIndex) onReorderMatches;

  const FavoritesContent({
    required this.onPressed,
    required this.onReorderLeagues,
    required this.onReorderTeams,
    required this.onReorderMatches,
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
    final favoritedLeagues = watchIt<LeagueStorageService>().value
        .map(
          (league) => League(
            id: league.id,
            name: league.name,
            logo: league.logo,
          ),
        )
        .toList();

    final favoritedTeams = watchIt<TeamStorageService>().value;

    final favoritedMatches = watchIt<MatchStorageService>().value;

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
            Text.rich(
              TextSpan(
                text: 'settingsFavoritesText1'.tr(),
                children: [
                  TextSpan(
                    text: 'settingsFavoritesText2'.tr(),
                    style: context.textStyles.bodyMdBold,
                  ),
                  const TextSpan(
                    text: '.',
                  ),
                ],
              ),
              style: context.textStyles.bodyMdLight,
            ),
            const SizedBox(height: 12),
            Text(
              'settingsFavoritesText3'.tr(),
              style: context.textStyles.bodyMdLight,
            ),
            const SizedBox(height: 12),
            Text(
              'settingsFavoritesText4'.tr(),
              style: context.textStyles.bodyMdLight,
            ),
            const SizedBox(height: 12),
            Text(
              'settingsFavoritesText5'.tr(),
              style: context.textStyles.bodyMdLight,
            ),
            const SizedBox(height: 24),

            ///
            /// LEAGUES
            ///
            Text(
              'fixturesFavoriteDialogLeagues'.tr(),
              style: context.textStyles.titleMd,
            ),
            const SizedBox(height: 12),
            if (favoritedLeagues.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'fixturesFavoriteDialogNoLeagues'.tr(),
                  style: context.textStyles.bodyMdLight,
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
                      color: context.colors.primaryBackgroundLight,
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
                          ? () {
                              HapticFeedback.lightImpact();
                              openLeague(
                                context,
                                leagueId: league.id!,
                                season: league.season ?? getCurrentSeasonYear().toString(),
                              );
                            }
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
                                style: context.textStyles.bodyMdLight.copyWith(
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
              style: context.textStyles.titleMd,
            ),
            const SizedBox(height: 12),
            if (favoritedTeams.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'fixturesFavoriteDialogNoTeams'.tr(),
                  style: context.textStyles.bodyMdLight,
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
                      color: context.colors.primaryBackgroundLight,
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
                          ? () {
                              HapticFeedback.lightImpact();
                              openTeam(
                                context,
                                teamId: team.id!,
                                season: getCurrentSeasonYear().toString(),
                              );
                            }
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
                                style: context.textStyles.bodyMdLight.copyWith(
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
            /// MATCHES
            ///
            Text(
              'fixturesFavoriteDialogMatches'.tr(),
              style: context.textStyles.titleMd,
            ),
            const SizedBox(height: 12),
            if (favoritedMatches.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'fixturesFavoriteDialogNoMatches'.tr(),
                  style: context.textStyles.bodyMdLight,
                ),
              )
            else
              SizedBox(
                height: (40 * favoritedMatches.length).toDouble(),
                width: double.maxFinite,
                child: ReorderableListView.builder(
                  proxyDecorator: (child, _, __) => ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Material(
                      color: context.colors.primaryBackgroundLight,
                      child: child,
                    ),
                  ),
                  onReorderStart: (_) => isDragging = true,
                  onReorderEnd: (_) => isDragging = false,
                  onReorder: (oldIndex, newIndex) {
                    if (newIndex > oldIndex) {
                      newIndex--;
                    }

                    widget.onReorderMatches(oldIndex, newIndex);
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: favoritedMatches.length,
                  itemBuilder: (_, index) {
                    final match = favoritedMatches[index];

                    return BalunButton(
                      key: ValueKey(match),
                      onPressed: match.matchId != null
                          ? () {
                              HapticFeedback.lightImpact();
                              openMatch(
                                context,
                                matchId: match.matchId!,
                              );
                            }
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
                              imageUrl: match.homeTeamLogo ?? BalunIcons.placeholderTeam,
                              height: 32,
                              width: 32,
                            ),
                            const SizedBox(width: 12),
                            Flexible(
                              flex: 5,
                              child: Text(
                                mixOrOriginalWords(match.homeTeamName) ?? '---',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.textStyles.bodyMdLight.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Text(
                                '-',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.textStyles.bodyMdLight.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Flexible(
                              flex: 5,
                              child: Text(
                                mixOrOriginalWords(match.awayTeamName) ?? '---',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.textStyles.bodyMdLight.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            BalunImage(
                              imageUrl: match.awayTeamLogo ?? BalunIcons.placeholderTeam,
                              height: 32,
                              width: 32,
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
