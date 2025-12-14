import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../models/teams/team_response.dart';
import '../../../../services/team_storage_service.dart';
import '../../../../theme/icons.dart';
import '../../../../theme/theme.dart';
import '../../../../util/dependencies.dart';
import '../../../../util/scroll_configuration.dart';
import '../../../../util/snackbars.dart';
import '../../../../util/string.dart';
import '../../../../util/team_seasons.dart';
import '../../../../util/word_mix.dart';
import '../../../../widgets/balun_button.dart';
import '../../../../widgets/balun_image.dart';
import '../../controllers/team_season_controller.dart';
import '../team_app_bar.dart';

class TeamMainInfo extends WatchingWidget {
  final TeamResponse team;

  const TeamMainInfo({
    required this.team,
  });

  @override
  Widget build(BuildContext context) {
    final seasonState = watchIt<TeamSeasonController>(
      instanceName: '${team.team?.id}',
    ).value;

    final favoritedTeams = watchIt<TeamStorageService>().value;

    final pageController = getIt
        .get<TeamSeasonController>(
          instanceName: '${team.team?.id}',
        )
        .controller;

    final years = generateYearList();

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),

          ///
          /// BACK & TEAM NAME
          ///
          TeamAppBar(
            onBackPressed: Navigator.of(context).pop,
            team: team.team,
            onFavoritePressed: () async {
              unawaited(
                HapticFeedback.lightImpact(),
              );

              final teamAdded = await getIt.get<TeamStorageService>().toggleTeam(
                passedTeam: team.team,
              );

              if (teamAdded ?? false) {
                showSnackbar(
                  context,
                  icon: team.team?.logo ?? BalunIcons.notificationTeam,
                  text: 'snackbarFavoriteTeam'.tr(),
                );
              }
            },
            isFavorited: favoritedTeams.any(
              (element) => element.id == team.team?.id,
            ),
          ),

          const SizedBox(height: 48),

          ///
          /// LOGO
          ///
          BalunImage(
            imageUrl: team.team?.logo ?? BalunIcons.placeholderTeam,
            height: 120,
            width: 120,
          ),

          const SizedBox(height: 16),

          ///
          /// NAME
          ///
          Text(
            mixOrOriginalWords(team.team?.name ?? '---') ?? '---',
            style: context.textStyles.headlineXlLoose,
            textAlign: TextAlign.center,
          ),

          ///
          /// COUNTRY
          ///
          if (team.team?.country != null)
            Text(
              team.team?.country != null
                  ? mixOrOriginalWords(
                          getCountryName(
                            country: team.team!.country!,
                          ),
                        ) ??
                        '---'
                  : '---',
              style: context.textStyles.bodyLg,
              textAlign: TextAlign.center,
            ),

          ///
          /// FOUNDED
          ///
          if (team.team?.founded != null) ...[
            const SizedBox(height: 4),
            Text(
              '${'leagueTeamsFounded'.tr()} ${team.team?.founded}',
              style: context.textStyles.labelMuted,
              textAlign: TextAlign.center,
            ),
          ],
          const SizedBox(height: 8),

          ///
          /// SEASON TITLE
          ///
          Text(
            'teamInfoSeason'.tr(),
            style: context.textStyles.bodyLgMediumMuted,
            textAlign: TextAlign.center,
          ),

          ///
          /// SEASONS
          ///
          SizedBox(
            height: 48,
            width: 200,
            child: ScrollConfiguration(
              behavior: BalunScrollConfiguration(),
              child: PageView(
                controller: pageController,
                physics: const BouncingScrollPhysics(),
                children: List.generate(
                  years.length,
                  (index) {
                    final year = years[index];

                    return BalunButton(
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        getIt
                            .get<TeamSeasonController>(
                              instanceName: '${team.team?.id}',
                            )
                            .updateState(year.toString());
                      },
                      child: Center(
                        child: Text(
                          '$year',
                          style: seasonState == year.toString() ? context.textStyles.titleMdExtraBold : context.textStyles.bodyLgMuted,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
