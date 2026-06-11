import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../../../models/youtube_search/youtube_item.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/dependencies.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image.dart';
import '../../../../controllers/match_highlights_controller.dart';

class MatchHighlightsContent extends StatelessWidget {
  final ({List<YouTubeItem> youTubeItems, YouTubeItem activeYouTubeItem}) youTubeData;
  final int? matchId;

  const MatchHighlightsContent({
    required this.youTubeData,
    required this.matchId,
  });

  @override
  Widget build(BuildContext context) {
    final youTubeController = getIt
        .get<MatchHighlightsController>(
          instanceName: '$matchId',
        )
        .youTubeController;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///
          /// VIDEO
          ///
          if (youTubeController != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    extensions: [
                      ...Theme.of(context).extensions.values,
                      YoutubePlayerTheme(
                        progressBarActiveColor: context.colors.primaryBackgroundLight,
                        progressBarBackgroundColor: Colors.transparent,
                        progressBarBufferedColor: context.colors.primaryForeground,
                        controlsColor: Colors.transparent,
                        timerStyle: context.textStyles.labelMedium.copyWith(
                          color: context.colors.primaryBackground,
                        ),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: YoutubePlayer(
                      controller: youTubeController,
                    ),
                  ),
                ),
              ),
            ),

          const SizedBox(height: 16),

          ///
          /// ACTIVE VIDEO INFO
          ///
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              youTubeData.activeYouTubeItem.snippet.title,
              style: context.textStyles.titleMdBold,
            ),
          ),
          const SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                youTubeData.activeYouTubeItem.snippet.channelTitle,
                style: context.textStyles.labelMedium,
                textAlign: TextAlign.right,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Text(
              youTubeData.activeYouTubeItem.snippet.description,
              style: context.textStyles.label,
            ),
          ),

          const SizedBox(height: 40),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'matchHighlightsSimilarVideos'.tr(),
              style: context.textStyles.headlineMdBold,
            ),
          ),

          const SizedBox(height: 20),

          ///
          /// VIDEOS
          ///
          ...List.generate(
            youTubeData.youTubeItems.length,
            (index) {
              final youTubeItem = youTubeData.youTubeItems[index];

              return BalunButton(
                onPressed: () => getIt
                    .get<MatchHighlightsController>(
                      instanceName: '$matchId',
                    )
                    .playVideo(
                      youTubeItem: youTubeItem,
                    ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: youTubeData.activeYouTubeItem == youTubeItem ? context.colors.primaryForeground : Colors.transparent,
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: BalunImage(
                          imageUrl: youTubeItem.snippet.thumbnails.defaultThumbnail.url,
                          width: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              youTubeItem.snippet.title,
                              style: context.textStyles.titleMdBold.copyWith(
                                color: youTubeData.activeYouTubeItem == youTubeItem ? context.colors.primaryBackground : null,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              youTubeItem.snippet.channelTitle,
                              style: context.textStyles.label.copyWith(
                                color: youTubeData.activeYouTubeItem == youTubeItem ? context.colors.primaryBackground : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
