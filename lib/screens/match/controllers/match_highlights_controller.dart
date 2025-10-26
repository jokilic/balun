import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../constants.dart';
import '../../../models/youtube_search/youtube_item.dart';
import '../../../services/logger_service.dart';
import '../../../services/youtube_search_service.dart';
import '../../../util/state.dart';

class MatchHighlightsController extends ValueNotifier<BalunState<({List<YouTubeItem> youTubeItems, YouTubeItem activeYouTubeItem})>> {
  final LoggerService logger;
  final YouTubeSearchService youTubeSearch;

  MatchHighlightsController({
    required this.logger,
    required this.youTubeSearch,
  }) : super(Initial());

  ///
  /// VARIABLES
  ///

  var fetched = false;
  YoutubePlayerController? youTubeController;
  var youTubeItems = <YouTubeItem>[];

  ///
  /// METHODS
  ///

  Future<void> getHighlights({
    required String? homeTeamName,
    required String? awayTeamName,
    required DateTime? matchDate,
    required String? leagueName,
  }) async {
    if (homeTeamName == null || awayTeamName == null || matchDate == null || leagueName == null) {
      value = Error(
        error: 'videoInfoNull'.tr(),
      );
      return;
    }

    if (fetched) {
      return;
    }

    value = Loading();

    final response = await youTubeSearch.getYouTubeVideoSearch(
      searchQuery: '$homeTeamName $awayTeamName highlights ${matchDate.year}',
      publishedAfter: matchDate.toUtc().subtract(
        BalunConstants.highlightsPublishLeadIn,
      ),
    );

    if (response.error != null) {
      value = Error(
        error: response.error,
      );
      return;
    }

    youTubeItems = List.from(response.youTubeSearch?.items ?? []);

    if (youTubeItems.isEmpty) {
      value = Empty();
      return;
    }

    fetched = true;

    youTubeController = YoutubePlayerController(
      initialVideoId: youTubeItems.first.id.videoId,
    );

    value = Success(
      data: (
        youTubeItems: youTubeItems,
        activeYouTubeItem: youTubeItems.first,
      ),
    );
  }

  void playVideo({required YouTubeItem youTubeItem}) {
    if (value is Success) {
      youTubeController!.load(youTubeItem.id.videoId);

      value = Success(
        data: (
          youTubeItems: youTubeItems,
          activeYouTubeItem: youTubeItem,
        ),
      );
    }
  }
}
