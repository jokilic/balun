import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
    }

    if (fetched) {
      return;
    }

    value = Loading();

    final date = '${matchDate!.day} ${matchDate.month} ${matchDate.year}';

    final searchQuery = '$homeTeamName $awayTeamName $date $leagueName';

    final response = await youTubeSearch.getYouTubeVideoSearch(
      searchQuery: searchQuery,
    );

    /// Successful request
    if (response.youTubeSearch != null && response.error == null) {
      /// There are items, update to success state
      if (response.youTubeSearch!.items.isNotEmpty) {
        fetched = true;

        youTubeItems = response.youTubeSearch!.items;

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

      /// There are no items, update to empty state
      else {
        value = Empty();
      }
    }

    /// Failed request
    if (response.youTubeSearch == null && response.error != null) {
      /// Error is not null, update to error state
      value = Error(
        error: response.error,
      );
    }
  }
}
