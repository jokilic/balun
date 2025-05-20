import 'package:flutter/material.dart';

import '../../../theme/icons.dart';
import '../../../theme/theme.dart';
import '../../../widgets/balun_button.dart';
import '../../../widgets/balun_image/balun_image.dart';

// TODO: Localize
class AboutContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        // controller: scrollController,
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///
            /// WHO MADE BALUN?
            ///
            Text(
              'Who made Balun?',
              style: context.textStyles.dialogSubtitle,
            ),
            const SizedBox(height: 12),
            Text(
              'My name is Josip and I make mobile applications for my work and sometimes in my free time.',
              style: context.textStyles.dialogText,
            ),
            const SizedBox(height: 12),
            Text(
              "I wanted to make an app to track football scores because I don't like popular ones which are full of ads and have cluttered UI.",
              style: context.textStyles.dialogText,
            ),
            const SizedBox(height: 24),

            ///
            /// CONTACT ME?
            ///
            Text(
              'Contact me?',
              style: context.textStyles.dialogSubtitle,
            ),
            const SizedBox(height: 12),
            Text(
              'You can contact me by sending me an e-mail.',
              style: context.textStyles.dialogText,
            ),
            const SizedBox(height: 12),
            Text(
              'Write any ideas, wishes or problems you encountered. I will work on it when I get some time and inspiration.',
              style: context.textStyles.dialogText,
            ),
            const SizedBox(height: 12),
            Text(
              'Write any ideas, wishes or problems you encountered. I will work on it when I get some time and inspiration.',
              style: context.textStyles.dialogText,
            ),

            ///
            /// EMAIL BUTTON
            ///
            BalunButton(
              onPressed: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: context.colors.white.withValues(alpha: 0.4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BalunImage(
                      imageUrl: BalunIcons.ballNavigation,
                      height: 24,
                      width: 24,
                      color: context.colors.black,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Contact me',
                      style: context.textStyles.dialogButton,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
