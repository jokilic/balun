import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../../../models/youtube_search/youtube_item.dart';
import '../../../../../../theme/icons.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/dependencies.dart';
import '../../../../../../util/youtube.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image/balun_image.dart';
import '../../../../controllers/match_highlights_controller.dart';

class MatchHighlightsContent extends StatelessWidget {
  final ({List<YouTubeItem> youTubeItems, YouTubeItem activeYouTubeItem}) youTubeData;
  final int? matchId;

  const MatchHighlightsContent({
    required this.youTubeData,
    required this.matchId,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///
            /// VIDEO
            ///
            if (getIt.get<MatchHighlightsController>(instanceName: '$matchId').youTubeController != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: YoutubePlayer(
                    controller: getIt.get<MatchHighlightsController>(instanceName: '$matchId').youTubeController!,
                    actionsPadding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                    topActions: [
                      BalunButton(
                        onPressed: () => launchYouTubeVideo(
                          videoId: youTubeData.activeYouTubeItem.id.videoId,
                        ),
                        child: Row(
                          children: [
                            BalunImage(
                              imageUrl: BalunIcons.youTube,
                              height: 28,
                              width: 28,
                              color: context.colors.white,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'matchHighlightsOpenInYouTube'.tr(),
                              style: TextStyle(
                                fontFamily: 'Lufga',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: context.colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    bottomActions: [
                      const CurrentPosition(),
                      const SizedBox(width: 8),
                      ProgressBar(
                        isExpanded: true,
                        colors: ProgressBarColors(
                          handleColor: context.colors.green,
                          playedColor: context.colors.greenish,
                          backgroundColor: context.colors.grey,
                          bufferedColor: context.colors.white,
                        ),
                      ),
                    ],
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
                style: context.textStyles.matchHighlightsVideoTitle,
              ),
            ),
            const SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  youTubeData.activeYouTubeItem.snippet.channelTitle,
                  style: context.textStyles.matchHighlightsVideoChannel,
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
                style: context.textStyles.matchHighlightsVideoDescription,
              ),
            ),

            const SizedBox(height: 40),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'matchHighlightsSimilarVideos'.tr(),
                style: context.textStyles.matchHighlightsSimilarVideos,
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
                      color: youTubeData.activeYouTubeItem == youTubeItem ? context.colors.green : Colors.transparent,
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
                                style: context.textStyles.matchHighlightsVideoTitle.copyWith(
                                  color: youTubeData.activeYouTubeItem == youTubeItem ? context.colors.white : null,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                youTubeItem.snippet.channelTitle,
                                style: context.textStyles.matchHighlightsVideoDescription.copyWith(
                                  color: youTubeData.activeYouTubeItem == youTubeItem ? context.colors.white : null,
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
