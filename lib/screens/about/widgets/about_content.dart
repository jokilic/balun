import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants.dart';
import '../../../theme/icons.dart';
import '../../../theme/theme.dart';
import '../../../util/app_version.dart';
import '../../../util/navigation.dart';
import '../../../util/sound.dart';
import '../../../widgets/balun_button.dart';
import '../../../widgets/balun_image.dart';
import 'about_video_widget.dart';

class AboutContent extends StatefulWidget {
  @override
  State<AboutContent> createState() => _AboutContentState();
}

class _AboutContentState extends State<AboutContent> {
  late final AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();

    audioPlayer = AudioPlayer()
      ..setAsset(
        BalunConstants.welcomeToBalunSound,
        preload: false,
      );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
    physics: const BouncingScrollPhysics(),
    children: [
      ///
      /// MY VIDEO
      ///
      Center(
        child: BalunButton(
          onLongPressed: () => playSound(
            audioPlayer: audioPlayer,
          ),
          child: Container(
            height: 160,
            width: 160,
            decoration: BoxDecoration(
              border: Border.all(
                color: context.colors.primaryForeground,
                width: 2,
              ),
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: AboutVideoWidget(),
            ),
          ),
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
            url: BalunConstants.josipKilicWebsite,
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
                  'josipkilic.com',
                  style: context.textStyles.bodyMdExtraBold,
                ),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(height: 16),

      ///
      /// GITHUB & EMAIL BUTTON
      ///
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ///
          /// GITHUB BUTTON
          ///
          BalunButton(
            onPressed: () => openUrlExternalBrowser(
              context,
              url: BalunConstants.josipGithubWebsite,
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
                    imageUrl: BalunIcons.programming,
                    height: 24,
                    width: 24,
                    color: context.colors.primaryForeground,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'GitHub',
                    style: context.textStyles.bodyMdExtraBold,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 16),

          ///
          /// EMAIL BUTTON
          ///
          BalunButton(
            onPressed: () {
              final uri = Uri.tryParse(BalunConstants.josipKilicEmail);

              if (uri != null) {
                launchUrl(
                  uri,
                  mode: LaunchMode.externalApplication,
                );
              }
            },
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
                    imageUrl: BalunIcons.mail,
                    height: 24,
                    width: 24,
                    color: context.colors.primaryForeground,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'E-Mail',
                    style: context.textStyles.bodyMdExtraBold,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 28),
      Text.rich(
        TextSpan(
          text: 'settingsAboutMyName'.tr(),
          children: [
            TextSpan(
              text: 'Josip',
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
        'settingsAboutMakeMobileApps'.tr(),
        style: context.textStyles.bodyMdLight,
      ),
      const SizedBox(height: 12),
      Text(
        'settingsAboutWantedToMakeApp'.tr(),
        style: context.textStyles.bodyMdLight,
      ),
      const SizedBox(height: 12),
      Text.rich(
        TextSpan(
          text: 'settingsAboutContactMe'.tr(),
          children: [
            TextSpan(
              text: 'e-mail',
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
        'settingsAboutWriteIdeas'.tr(),
        style: context.textStyles.bodyMdLight,
      ),
      Text(
        'settingsAboutWorkWhenTime'.tr(),
        style: context.textStyles.bodyMdLight,
      ),
      const SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BalunButton(
            onLongPressed: () => playSound(
              audioPlayer: audioPlayer,
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: context.colors.primaryForeground,
                  width: 2,
                ),
              ),
              child: ClipOval(
                child: Image.asset(
                  BalunIcons.appIcon,
                  height: 48,
                  width: 48,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'appName'.tr(),
                style: context.textStyles.titleLgExtraBold,
              ),
              FutureBuilder(
                future: getAppVersion(),
                builder: (_, snapshot) {
                  final version = snapshot.data;

                  if (version != null) {
                    return Text(
                      'v$version',
                      style: context.textStyles.bodyLgTightMuted,
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ],
      ),
      const SizedBox(height: 28),
    ],
  );
}
