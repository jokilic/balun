import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../../../models/fixtures/league/league.dart';
import '../../../routing.dart';
import '../../../services/league_storage_service.dart';
import '../../../services/team_storage_service.dart';
import '../../../theme/icons.dart';
import '../../../theme/theme.dart';
import '../../../widgets/balun_button.dart';
import '../../../widgets/balun_image.dart';

class FixturesPopularDialog extends WatchingWidget {
  final Function() onPressed;

  const FixturesPopularDialog({
    required this.onPressed,
  });

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

    return AlertDialog(
      elevation: 0,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///
          /// TITLE
          ///
          Text(
            'fixturesFavoriteTitle'.tr(),
            style: context.textStyles.dialogTitle,
          ),
          const SizedBox(height: 8),
          Flexible(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///
                  /// TEXT
                  ///
                  Text(
                    'fixturesFavoriteDialogText1'.tr(),
                    style: context.textStyles.dialogText,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'fixturesFavoriteDialogText2'.tr(),
                    style: context.textStyles.dialogText,
                  ),
                  const SizedBox(height: 16),

                  ///
                  /// LEAGUES
                  ///
                  Text(
                    'fixturesFavoriteDialogLeagues'.tr(),
                    style: context.textStyles.dialogSubtitle,
                  ),
                  const SizedBox(height: 12),
                  if (favoritedLeagues.isEmpty)
                    Text(
                      'fixturesFavoriteDialogNoLeagues'.tr(),
                      style: context.textStyles.dialogText,
                    )
                  else
                    ...favoritedLeagues
                        .map(
                          (league) => BalunButton(
                            onPressed: league.id != null
                                ? () => openLeague(
                                      context,
                                      leagueId: league.id!,
                                      season: DateTime.now().year,
                                    )
                                : null,
                            child: Container(
                              color: Colors.transparent,
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: BalunImage(
                                      imageUrl: league.logo ?? BalunIcons.placeholderLeague,
                                      height: 32,
                                      width: 32,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      league.name ?? '?',
                                      style: context.textStyles.dialogText.copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  const SizedBox(height: 16),

                  ///
                  /// TEAMS
                  ///
                  Text(
                    'fixturesFavoriteDialogTeams'.tr(),
                    style: context.textStyles.dialogSubtitle,
                  ),
                  const SizedBox(height: 12),
                  if (favoritedTeams.isEmpty)
                    Text(
                      'fixturesFavoriteDialogNoTeams'.tr(),
                      style: context.textStyles.dialogText,
                    )
                  else
                    ...favoritedTeams
                        .map(
                          (team) => BalunButton(
                            onPressed: team.id != null
                                ? () => openTeam(
                                      context,
                                      teamId: team.id!,
                                      season: DateTime.now().year,
                                    )
                                : null,
                            child: Container(
                              color: Colors.transparent,
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: BalunImage(
                                      imageUrl: team.logo ?? BalunIcons.placeholderLeague,
                                      height: 32,
                                      width: 32,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      team.name ?? '?',
                                      style: context.textStyles.dialogText.copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                ],
              ),
            ),
          ),
        ],
      ),
      actions: [
        BalunButton(
          onPressed: onPressed,
          child: Text(
            'fixturesDialogOkay'.tr().toUpperCase(),
            style: context.textStyles.dialogButton,
          ),
        ),
      ],
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
      actionsPadding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      backgroundColor: context.colors.greenish,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: context.colors.black,
          width: 2,
        ),
      ),
    );
  }
}
