import 'package:flutter/material.dart';

import '../../../../../../models/news/news_result.dart';
import '../../../../../../util/date_time.dart';
import '../../../../../../util/navigation.dart';
import '../../../../../../widgets/balun_seperator.dart';
import 'team_news_list_tile.dart';

class TeamNewsContent extends StatelessWidget {
  final List<NewsResult>? news;

  const TeamNewsContent({
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    final cleanedNews = news?.toSet().toList();

    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cleanedNews?.length ?? 0,
      itemBuilder: (_, index) {
        final newsResult = cleanedNews![index];

        return TeamNewsListTile(
          onPressed: () {
            if (newsResult.link != null) {
              openUrlExternalBrowser(
                context,
                url: newsResult.link,
              );
            }
          },
          newsResult: newsResult,
          cleanDate: parseDateTimeago(
            newsResult.pubDate,
            context: context,
          ),
        );
      },
      separatorBuilder: (_, __) => const BalunSeperator(),
    );
  }
}
