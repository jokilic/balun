import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../theme/icons.dart';
import '../../../theme/theme.dart';
import '../../../util/navigation.dart';
import '../../../widgets/balun_button.dart';
import '../../../widgets/balun_image.dart';

List<Widget> getStatusStaticWidgetList(BuildContext context) => [
  ///
  /// API-FOOTBALL LOGO
  ///
  const Center(
    child: BalunImage(
      imageUrl: BalunIcons.apiFootball,
      fit: BoxFit.cover,
      height: 160,
      width: 160,
      radius: 100,
    ),
  ),
  const SizedBox(height: 20),

  ///
  /// WEBSITE BUTTON
  ///
  Center(
    child: BalunButton(
      onPressed: () => openUrlExternalBrowser(
        context,
        url: BalunConstants.apiFootballWebsite,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: context.colors.primaryBackgroundLight,
          border: Border.all(
            color: context.colors.primaryForeground,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            BalunImage(
              imageUrl: BalunIcons.website,
              height: 24,
              width: 24,
              color: context.colors.primaryForeground,
            ),
            const SizedBox(width: 8),
            Text(
              'api-football.com',
              style: context.textStyles.bodyMdExtraBold,
            ),
          ],
        ),
      ),
    ),
  ),
  const SizedBox(height: 28),
  Text.rich(
    TextSpan(
      text: 'statusNotPossible'.tr(),
      children: [
        TextSpan(
          text: 'API-Football',
          style: context.textStyles.bodyMdBold,
        ),
        const TextSpan(
          text: '.',
        ),
      ],
    ),
    style: context.textStyles.bodyMdLight,
  ),
  const SizedBox(height: 12),
  Text(
    'statusDataUsedToShow'.tr(),
    style: context.textStyles.bodyMdLight,
  ),
  const SizedBox(height: 20),
];
