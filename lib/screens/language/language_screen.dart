import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants.dart';
import '../../services/logger_service.dart';
import '../../util/dependencies.dart';
import '../../util/language.dart';
import '../../util/snackbars.dart';
import 'language_controller.dart';
import 'widgets/language_app_bar.dart';
import 'widgets/language_content.dart';

class LanguageScreen extends WatchingStatefulWidget {
  const LanguageScreen({
    required super.key,
  });

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  void initState() {
    super.initState();

    registerIfNotInitialized<LanguageController>(
      () => LanguageController(
        logger: getIt.get<LoggerService>(),
      ),
      instanceName: 'language',
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    getIt
        .get<LanguageController>(
          instanceName: 'language',
        )
        .init(
          locale: context.locale,
        );
  }

  @override
  Widget build(BuildContext context) {
    final languageState = watchIt<LanguageController>(
      instanceName: 'language',
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
              LanguageAppBar(
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
                  child: LanguageContent(
                    languageState: languageState,
                    onPressedLanguage: (languageCode) async {
                      await getIt
                          .get<LanguageController>(instanceName: 'language')
                          .onPressedLanguage(
                            context: context,
                            languageCode: languageCode,
                          );

                      ScaffoldMessenger.of(context).hideCurrentSnackBar();

                      await Future.delayed(
                        BalunConstants.longAnimationDuration,
                      );

                      final snackbarText = getLanguageSnackbarText(
                        languageCode: languageCode,
                      );

                      if (snackbarText?.isNotEmpty ?? false) {
                        showSnackbar(
                          context,
                          icon: getLanguageIcon(
                            languageCode: languageCode,
                          ),
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
