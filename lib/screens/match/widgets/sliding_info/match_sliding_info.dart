import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../constants.dart';
import '../../../../models/fixtures/fixture_response.dart';
import '../../../../theme/theme.dart';
import '../../../../util/dependencies.dart';
import '../../../../util/string.dart';
import '../../controllers/match_section_controller.dart';
import 'match_active_section.dart';
import 'match_section_titles.dart';

class MatchSlidingInfo extends WatchingWidget {
  final FixtureResponse match;
  final ScrollController scrollController;
  final String season;

  const MatchSlidingInfo({
    required this.match,
    required this.scrollController,
    required this.season,
  });

  @override
  Widget build(BuildContext context) {
    final matchSection = watchIt<MatchSectionController>(
      instanceName: '${match.fixture?.id}',
    ).value;

    return ListView(
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      children: [
        ///
        /// BLACK LINE
        ///
        Center(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            height: 4,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: context.colors.black.withOpacity(0.5),
            ),
          ),
        ),

        const SizedBox(height: 8),

        ///
        /// SECTIONS
        ///
        MatchSectionTitles(
          activeMatchSection: matchSection,
          titlePressed: getIt
              .get<MatchSectionController>(
                instanceName: '${match.fixture?.id}',
              )
              .updateState,
          matchFinished: isMatchFinished(
            statusShort: match.fixture?.status?.short ?? '--',
          ),
        ),

        const SizedBox(height: 24),

        ///
        /// ACTIVE SECTION
        ///
        Animate(
          key: ValueKey(matchSection),
          effects: const [
            FadeEffect(
              curve: Curves.easeIn,
              duration: BalunConstants.animationDuration,
            ),
          ],
          child: MatchActiveSection(
            match: match,
            matchSection: matchSection,
            season: season,
          ),
        ),
      ],
    );
  }
}
