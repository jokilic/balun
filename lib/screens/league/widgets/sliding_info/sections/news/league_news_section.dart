import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../../constants.dart';
import '../../../../../../util/dependencies.dart';
import '../../../../../../util/state.dart';
import '../../../../../../widgets/balun_empty.dart';
import '../../../../../../widgets/balun_error.dart';
import '../../../../controllers/league_news_controller.dart';
import 'league_news_content.dart';
import 'league_news_loading.dart';

class LeagueNewsSection extends WatchingStatefulWidget {
  final int? leagueId;
  final String? leagueName;

  const LeagueNewsSection({
    required this.leagueId,
    required this.leagueName,
  });

  @override
  State<LeagueNewsSection> createState() => _LeagueNewsSectionState();
}

class _LeagueNewsSectionState extends State<LeagueNewsSection> {
  @override
  void initState() {
    super.initState();
    getIt
        .get<LeagueNewsController>(
          instanceName: '${widget.leagueId}',
        )
        .getNewsFromLeague(
          leagueName: widget.leagueName,
        );
  }

  @override
  Widget build(BuildContext context) {
    final newsState = watchIt<LeagueNewsController>(
      instanceName: '${widget.leagueId}',
    ).value;

    return Animate(
      key: ValueKey(newsState),
      effects: const [
        FadeEffect(
          curve: Curves.easeIn,
          duration: BalunConstants.animationDuration,
        ),
      ],
      child: switch (newsState) {
        Initial() => BalunError(
          error: 'initialState'.tr(),
          isSmall: true,
        ),
        Loading() => LeagueNewsLoading(),
        Empty() => BalunEmpty(
          message: 'leagueNewsEmptyState'.tr(),
          isSmall: true,
        ),
        Error() => BalunError(
          error: (newsState as Error).error ?? 'leagueNewsErrorState'.tr(),
          isSmall: true,
        ),
        Success() => LeagueNewsContent(
          news: (newsState as Success).data,
        ),
      },
    );
  }
}
