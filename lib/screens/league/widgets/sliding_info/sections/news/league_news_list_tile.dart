import 'package:flutter/material.dart';

import '../../../../../../models/news/news_result.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/word_mix.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image/balun_image.dart';

class LeagueNewsListTile extends StatelessWidget {
  final NewsResult newsResult;
  final String? cleanDate;
  final Function() onPressed;

  const LeagueNewsListTile({
    required this.newsResult,
    required this.cleanDate,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => BalunButton(
        onPressed: onPressed,
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///
              /// PHOTO
              ///
              if (newsResult.imageUrl != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: BalunImage(
                    imageUrl: newsResult.imageUrl!,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    radius: 8,
                  ),
                ),
                const SizedBox(height: 16),
              ],

              Row(
                children: [
                  ///
                  /// TITLE
                  ///
                  Expanded(
                    child: Text(
                      mixOrOriginalWords(newsResult.title) ?? '---',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: context.textStyles.leagueTeamsTitle,
                    ),
                  ),

                  const SizedBox(width: 24),

                  ///
                  /// DATE & TIME
                  ///
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(height: 8),

                      /// Date
                      if (cleanDate != null)
                        Text(
                          cleanDate!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                          style: context.textStyles.newsDateTime,
                        ),

                      /// Favicon
                      const SizedBox(height: 8),
                      IconButton(
                        onPressed: onPressed,
                        style: IconButton.styleFrom(
                          padding: const EdgeInsets.all(4),
                          highlightColor: context.colors.black.withValues(alpha: 0.6),
                          fixedSize: const Size(40, 40),
                          shape: const CircleBorder(),
                          side: BorderSide(
                            color: context.colors.black,
                            width: 1.5,
                          ),
                        ),
                        icon: Center(
                          child: newsResult.sourceIcon != null
                              ? ClipOval(
                                  child: BalunImage(
                                    imageUrl: newsResult.sourceIcon!,
                                  ),
                                )
                              : Text(
                                  newsResult.sourceUrl?.replaceAll(RegExp(r'https?://(www\.)?'), '').substring(0, 2) ?? '?',
                                  style: context.textStyles.newsTwoLetterSource,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),

              ///
              /// DESCRIPTION
              ///
              Text(
                mixOrOriginalWords(newsResult.description) ?? '---',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: context.textStyles.leagueTeamsCountry,
              ),
            ],
          ),
        ),
      );
}
