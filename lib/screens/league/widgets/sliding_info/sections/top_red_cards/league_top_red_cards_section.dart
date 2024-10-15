import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../../constants.dart';
import '../../../../../../util/dependencies.dart';
import '../../../../../../util/state.dart';
import '../../../../../../widgets/balun_empty.dart';
import '../../../../../../widgets/balun_error.dart';
import '../../../../controllers/league_top_red_cards_controller.dart';
import 'league_top_red_cards_content.dart';
import 'league_top_red_cards_loading.dart';

class LeagueTopRedCardsSection extends WatchingStatefulWidget {
  final int? leagueId;
  final String? season;

  const LeagueTopRedCardsSection({
    required this.leagueId,
    required this.season,
  });

  @override
  State<LeagueTopRedCardsSection> createState() => _LeagueTopRedCardsSectionState();
}

class _LeagueTopRedCardsSectionState extends State<LeagueTopRedCardsSection> {
  @override
  void initState() {
    super.initState();
    getIt
        .get<LeagueTopRedCardsController>(
          instanceName: '${widget.leagueId}',
        )
        .getTopRedCards(
          leagueId: widget.leagueId,
          season: widget.season,
        );
  }

  @override
  Widget build(BuildContext context) {
    final topRedCardsState = watchIt<LeagueTopRedCardsController>(
      instanceName: '${widget.leagueId}',
    ).value;

    return Animate(
      key: ValueKey(topRedCardsState),
      effects: const [
        FadeEffect(
          curve: Curves.easeIn,
          duration: BalunConstants.animationDuration,
        ),
      ],
      child: switch (topRedCardsState) {
        Initial() => BalunError(
            error: 'initialState'.tr(),
            isSmall: true,
          ),
        Loading() => LeagueTopRedCardsLoading(),
        Empty() => BalunEmpty(
            message: 'leagueTopRedCardsEmptyState'.tr(),
            isSmall: true,
          ),
        Error() => BalunError(
            error: (topRedCardsState as Error).error ?? 'leagueTopRedCardsErrorState'.tr(),
            isSmall: true,
          ),
        Success() => LeagueTopRedCardsContent(
            redCards: (topRedCardsState as Success).data,
            season: widget.season ?? DateTime.now().year.toString(),
          ),
      },
    );
  }
}
