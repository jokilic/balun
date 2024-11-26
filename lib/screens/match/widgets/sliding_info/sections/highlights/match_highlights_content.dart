import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../../../models/youtube_search/youtube_item.dart';
import '../../../../../../theme/theme.dart';

class MatchHighlightsContent extends StatelessWidget {
  final ({YoutubePlayerController youtubeController, YouTubeItem youTubeItem}) data;

  const MatchHighlightsContent({
    required this.data,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Column(
          children: [
            ///
            /// VIDEO
            ///
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: YoutubePlayer(
                controller: data.youtubeController,
                actionsPadding: const EdgeInsets.only(left: 16),
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
                  FullScreenButton(
                    color: context.colors.white,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            ///
            /// VIDEO INFO
            ///
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                data.youTubeItem.snippet.title,
                style: context.textStyles.matchHighlightsVideoTitle,
              ),
            ),
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                data.youTubeItem.snippet.channelTitle,
                style: context.textStyles.matchHighlightsVideoChannel,
                textAlign: TextAlign.right,
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                data.youTubeItem.snippet.description,
                style: context.textStyles.matchHighlightsVideoDescription,
              ),
            ),
          ],
        ),
      );
}
