import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants.dart';
import '../../services/logger_service.dart';
import '../../services/theme_service.dart';
import '../../theme/icons.dart';
import '../../util/dependencies.dart';
import '../../util/snackbars.dart';
import '../../util/theme.dart';
import 'theme_controller.dart';
import 'widgets/theme_app_bar.dart';
import 'widgets/theme_content.dart';

class ThemeScreen extends WatchingStatefulWidget {
  const ThemeScreen({
    required super.key,
  });

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  @override
  void initState() {
    super.initState();

    registerIfNotInitialized<ThemeController>(
      () => ThemeController(
        logger: getIt.get<LoggerService>(),
        theme: getIt.get<ThemeService>(),
      ),
      instanceName: 'theme',
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeState = watchIt<ThemeController>(
      instanceName: 'theme',
    ).value;

    return Scaffold(
      body: SafeArea(
        child: Animate(
          effects: const [
            FadeEffect(
              curve: Curves.easeIn,
              duration: BalunConstants.longAnimationDuration,
            ),
          ],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              ///
              /// APP BAR
              ///
              ThemeAppBar(
                onPressed: Navigator.of(context).pop,
              ),
              const SizedBox(height: 8),

              ///
              /// CONTENT
              ///
              Expanded(
                child: Animate(
                  effects: const [
                    FadeEffect(
                      curve: Curves.easeIn,
                      duration: BalunConstants.animationDuration,
                    ),
                  ],
                  child: ThemeContent(
                    themeState: themeState,
                    onPressedTheme: (themeEnum) async {
                      await getIt
                          .get<ThemeController>(instanceName: 'theme')
                          .onPressedTheme(
                            themeEnum: themeEnum,
                          );

                      ScaffoldMessenger.of(context).hideCurrentSnackBar();

                      await Future.delayed(
                        BalunConstants.longAnimationDuration,
                      );

                      final snackbarText = getThemeSnackbarText(themeEnum);

                      if (snackbarText?.isNotEmpty ?? false) {
                        showSnackbar(
                          context,
                          icon: BalunIcons.theme,
                          text: snackbarText!,
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
