import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../../constants.dart';
import '../../../../../../util/dependencies.dart';
import '../../../../../../util/state.dart';
import '../../../../../../widgets/balun_empty.dart';
import '../../../../../../widgets/balun_error.dart';
import '../../../../controllers/team_news_controller.dart';
import 'team_news_content.dart';
import 'team_news_loading.dart';

class TeamNewsSection extends WatchingStatefulWidget {
  final int? teamId;
  final String? teamName;

  const TeamNewsSection({
    required this.teamId,
    required this.teamName,
  });

  @override
  State<TeamNewsSection> createState() => _TeamNewsSectionState();
}

class _TeamNewsSectionState extends State<TeamNewsSection> {
  @override
  void initState() {
    super.initState();
    getIt
        .get<TeamNewsController>(
          instanceName: '${widget.teamId}',
        )
        .getNewsFromTeam(
          teamName: widget.teamName,
        );
  }

  @override
  Widget build(BuildContext context) {
    final newsState = watchIt<TeamNewsController>(
      instanceName: '${widget.teamId}',
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
        Loading() => TeamNewsLoading(),
        Empty() => BalunEmpty(
            message: 'teamNewsEmptyState'.tr(),
            isSmall: true,
          ),
        Error() => BalunError(
            error: (newsState as Error).error ?? 'teamNewsErrorState'.tr(),
            isSmall: true,
          ),
        Success() => TeamNewsContent(
            news: (newsState as Success).data,
          ),
      },
    );
  }
}
