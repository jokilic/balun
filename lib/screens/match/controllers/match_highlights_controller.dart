import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../models/youtube_search/youtube_item.dart';
import '../../../services/logger_service.dart';
import '../../../services/youtube_search_service.dart';
import '../../../util/state.dart';

class MatchHighlightsController extends ValueNotifier<BalunState<({List<YouTubeItem> youTubeItems, YouTubeItem activeYouTubeItem})>> implements Disposable {
  final LoggerService logger;
  final YouTubeSearchService youTubeSearch;

  MatchHighlightsController({
    required this.logger,
    required this.youTubeSearch,
  }) : super(Initial());

  @override
  FutureOr onDispose() {
    youTubeController?.close();
  }

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
      searchQuery: '$homeTeamName $awayTeamName highligths',
      publishedAfter: matchDate.toUtc().toIso8601String(),
    );

    /// Successful request
    if (response.youTubeSearch != null && response.error == null) {
      /// There are items, update to success state
      if (response.youTubeSearch!.items.isNotEmpty) {
        fetched = true;

        youTubeItems = response.youTubeSearch!.items;

        youTubeController = YoutubePlayerController.fromVideoId(
          videoId: youTubeItems.first.id.videoId,
          autoPlay: true,
          params: const YoutubePlayerParams(
            enableCaption: false,
            showVideoAnnotations: false,
          ),
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

  void playVideo({required YouTubeItem youTubeItem}) {
    if (value is Success) {
      youTubeController!.loadVideoById(
        videoId: youTubeItem.id.videoId,
      );

      value = Success(
        data: (
          youTubeItems: youTubeItems,
          activeYouTubeItem: youTubeItem,
        ),
      );
    }
  }
}
