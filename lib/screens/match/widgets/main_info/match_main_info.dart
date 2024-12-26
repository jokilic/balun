import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../models/fixtures/fixture_response.dart';
import '../../../../models/leagues/league/league.dart';
import '../../../../routing.dart';
import '../../../../services/league_storage_service.dart';
import '../../../../theme/icons.dart';
import '../../../../theme/theme.dart';
import '../../../../util/date_time.dart';
import '../../../../util/dependencies.dart';
import '../../../../util/string.dart';
import '../../../../util/word_mix.dart';
import '../../../../widgets/balun_button.dart';
import '../match_app_bar.dart';
import 'match_logo.dart';
import 'match_minute.dart';

class MatchMainInfo extends WatchingWidget {
  final FixtureResponse match;

  const MatchMainInfo({
    required this.match,
  });

  @override
  Widget build(BuildContext context) {
    final favoritedLeagues = watchIt<LeagueStorageService>().value;

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
          /// BACK & LEAGUE
          ///
          MatchAppBar(
            onBackPressed: Navigator.of(context).pop,
            league: match.league!,
            onFavoritePressed: () => getIt.get<LeagueStorageService>().toggleLeague(
                  passedLeague: League(
                    id: match.league?.id,
                    name: match.league?.name,
                    logo: match.league?.logo,
                  ),
                ),
            isFavorited: favoritedLeagues.any(
              (element) => element.id == match.league?.id,
            ),
          ),

          const SizedBox(height: 48),

          ///
          /// LOGOS, TEAM NAMES & MINUTE
          ///
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///
              /// HOME
              ///
              Expanded(
                child: BalunButton(
                  onPressed: match.teams?.home?.id != null
                      ? () => openTeam(
                            context,
                            teamId: match.teams!.home!.id!,
                            season: match.league?.season ?? DateTime.now().year.toString(),
                          )
                      : null,
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        ///
                        /// HOME LOGO
                        ///
                        MatchLogo(
                          logo: match.teams?.home?.logo ?? BalunIcons.placeholderTeam,
                        ),

                        const SizedBox(height: 16),

                        ///
                        /// HOME NAME
                        ///
                        Text(
                          mixOrOriginalWords(match.teams?.home?.name) ?? '---',
                          style: context.textStyles.fixturesName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              ///
              /// MINUTE
              ///
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    MatchMinute(
                      minutes: getMatchMinutesOrNull(
                        statusShort: match.fixture?.status?.short ?? '--',
                        minutes: match.fixture?.status?.elapsed ?? 0,
                        extra: match.fixture?.status?.extra,
                      ),
                      textStatus: getMatchStatusShortOrNull(
                        statusShort: match.fixture?.status?.short ?? '--',
                      ),
                      timeBeforeMatch: isMatchNotStarted(
                                statusShort: match.fixture?.status?.short ?? '--',
                              ) &&
                              match.fixture?.timestamp != null
                          ? DateFormat(
                              'HH:mm',
                              context.locale.toLanguageTag(),
                            ).format(
                              parseTimestamp(
                                match.fixture!.timestamp,
                              )!,
                            )
                          : null,
                    ),
                  ],
                ),
              ),

              ///
              /// AWAY
              ///
              Expanded(
                child: BalunButton(
                  onPressed: match.teams?.away?.id != null
                      ? () => openTeam(
                            context,
                            teamId: match.teams!.away!.id!,
                            season: match.league?.season ?? DateTime.now().year.toString(),
                          )
                      : null,
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        ///
                        /// AWAY LOGO
                        ///
                        MatchLogo(
                          logo: match.teams?.away?.logo ?? BalunIcons.placeholderTeam,
                        ),

                        const SizedBox(height: 16),

                        ///
                        /// AWAY NAME
                        ///
                        Text(
                          mixOrOriginalWords(match.teams?.away?.name) ?? '---',
                          style: context.textStyles.fixturesName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          ///
          /// SCORE & GOALSCORERS
          ///
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///
              /// HOME SCORERS
              ///
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    if (match.events?.isNotEmpty ?? false)
                      ...match.events!
                          .where(
                        (event) => event.team?.id == match.teams?.home?.id && event.type?.toLowerCase() == 'goal' && event.detail?.toLowerCase() != 'missed penalty',
                      )
                          .map(
                        (event) {
                          final playerName = mixOrOriginalWords(getLastWord(event.player?.name ?? '---')) ?? '---';

                          return BalunButton(
                            onPressed: event.player?.id != null
                                ? () => openPlayer(
                                      context,
                                      playerId: event.player!.id!,
                                      season: match.league?.season ?? DateTime.now().year.toString(),
                                    )
                                : null,
                            child: Container(
                              color: Colors.transparent,
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    event.time?.extra != null ? "${(event.time?.elapsed ?? 0) + (event.time?.extra ?? 0)}'" : "${event.time?.elapsed}'",
                                    style: context.textStyles.matchGoal.copyWith(
                                      color: context.colors.black.withOpacity(0.4),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      event.detail?.toLowerCase() == 'penalty'
                                          ? '$playerName (${'matchInfoPenalty'.tr()})'
                                          : event.detail?.toLowerCase() == 'own goal'
                                              ? '$playerName (${'matchInfoOwnGoal'.tr()})'
                                              : playerName,
                                      style: context.textStyles.matchGoal,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ).toList(),
                  ],
                ),
              ),

              ///
              /// SCORE
              ///
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: '${match.goals?.home ?? '-'}'),
                          TextSpan(
                            text: ':',
                            style: context.textStyles.fixturesScore.copyWith(
                              color: context.colors.black.withOpacity(0.2),
                            ),
                          ),
                          TextSpan(text: '${match.goals?.away ?? '-'}'),
                        ],
                      ),
                      style: context.textStyles.fixturesScore,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              ///
              /// AWAY SCORERS
              ///
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    if (match.events?.isNotEmpty ?? false)
                      ...match.events!
                          .where(
                        (event) => event.team?.id == match.teams?.away?.id && event.type?.toLowerCase() == 'goal' && event.detail?.toLowerCase() != 'missed penalty',
                      )
                          .map(
                        (event) {
                          final playerName = mixOrOriginalWords(getLastWord(event.player?.name ?? '---')) ?? '---';

                          return BalunButton(
                            onPressed: event.player?.id != null
                                ? () => openPlayer(
                                      context,
                                      playerId: event.player!.id!,
                                      season: match.league?.season ?? DateTime.now().year.toString(),
                                    )
                                : null,
                            child: Container(
                              color: Colors.transparent,
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      event.detail?.toLowerCase() == 'penalty'
                                          ? '$playerName (${'matchInfoPenalty'.tr()})'
                                          : event.detail?.toLowerCase() == 'own goal'
                                              ? '$playerName (${'matchInfoOwnGoal'.tr()})'
                                              : playerName,
                                      style: context.textStyles.matchGoal,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    event.time?.extra != null ? "${(event.time?.elapsed ?? 0) + (event.time?.extra ?? 0)}'" : "${event.time?.elapsed}'",
                                    style: context.textStyles.matchGoal.copyWith(
                                      color: context.colors.black.withOpacity(0.4),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ).toList(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
