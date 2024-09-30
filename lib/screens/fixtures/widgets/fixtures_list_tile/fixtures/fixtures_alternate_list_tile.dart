import 'package:flutter/material.dart';

import '../../../../../models/fixtures/fixture_response.dart';
import '../../../../../theme/icons.dart';
import '../../../../../theme/theme.dart';
import '../../../../../widgets/balun_button.dart';
import '../../../../../widgets/balun_image.dart';

class FixturesAlternateListTile extends StatelessWidget {
  final FixtureResponse fixture;
  final String scoreText;
  final Function()? fixturePressed;

  const FixturesAlternateListTile({
    required this.fixture,
    required this.scoreText,
    required this.fixturePressed,
  });

  @override
  Widget build(BuildContext context) => BalunButton(
        onPressed: fixturePressed,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: context.colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              ///
              /// HOME
              ///
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        fixture.teams?.home?.name ?? '---',
                        style: context.textStyles.fixturesNameAlternate,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(width: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: BalunImage(
                        imageUrl: fixture.teams?.home?.logo ?? BalunIcons.placeholderTeam,
                        height: 28,
                        width: 28,
                      ),
                    ),
                  ],
                ),
              ),

              ///
              /// SCORE
              ///
              const SizedBox(width: 12),
              Text(
                scoreText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textStyles.fixturesScoreAlternate,
                textAlign: TextAlign.center,
              ),
              const SizedBox(width: 12),

              ///
              /// AWAY
              ///
              Expanded(
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: BalunImage(
                        imageUrl: fixture.teams?.away?.logo ?? BalunIcons.placeholderTeam,
                        height: 28,
                        width: 28,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        fixture.teams?.away?.name ?? '---',
                        style: context.textStyles.fixturesNameAlternate,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
