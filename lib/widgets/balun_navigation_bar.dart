import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../constants.dart';
import '../services/balun_navigation_bar_badge_service.dart';
import '../services/balun_navigation_bar_service.dart';
import '../theme/icons.dart';
import '../theme/theme.dart';
import '../util/dependencies.dart';
import 'balun_image.dart';

class BalunNavigationBar extends WatchingWidget {
  @override
  Widget build(BuildContext context) {
    final badgeNumber = watchIt<BalunNavigationBarBadgeService>().value;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(20),
      ),
      child: NavigationBar(
        height: 88,
        backgroundColor: context.colors.black,
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        elevation: 0,
        indicatorColor: Colors.transparent,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        selectedIndex: watchIt<BalunNavigationBarService>().value.index,
        onDestinationSelected: (newIndex) => getIt.get<BalunNavigationBarService>().changeNavigationBarIndex(
              BalunNavigationBarEnum.values[newIndex],
            ),
        animationDuration: BalunConstants.animationDuration,
        destinations: [
          ///
          /// FIXTURES
          ///
          NavigationDestination(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                ///
                /// ICON
                ///
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.colors.grey,
                  ),
                  child: BalunImage(
                    imageUrl: BalunIcons.ballNavigation,
                    height: 24,
                    width: 24,
                    color: context.colors.white.withOpacity(0.25),
                  ),
                ),

                ///
                /// BADGE
                ///
                Positioned(
                  right: -6,
                  top: -4,
                  child: AnimatedOpacity(
                    opacity: badgeNumber != null ? 1 : 0,
                    duration: BalunConstants.longAnimationDuration,
                    curve: Curves.easeIn,
                    child: Container(
                      height: 20,
                      width: 20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.colors.blue,
                      ),
                      child: Text(
                        '${badgeNumber ?? ''}',
                        maxLines: 1,
                        style: context.textStyles.badgeNumber,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            selectedIcon: Stack(
              clipBehavior: Clip.none,
              children: [
                ///
                /// ICON
                ///
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.colors.white,
                  ),
                  child: BalunImage(
                    imageUrl: BalunIcons.ballNavigation,
                    height: 24,
                    width: 24,
                    color: context.colors.black,
                  ),
                ),

                ///
                /// BADGE
                ///
                Positioned(
                  right: -6,
                  top: -4,
                  child: AnimatedOpacity(
                    opacity: badgeNumber != null ? 1 : 0,
                    duration: BalunConstants.longAnimationDuration,
                    curve: Curves.easeIn,
                    child: Container(
                      height: 20,
                      width: 20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.colors.blue,
                      ),
                      child: Text(
                        '${badgeNumber ?? ''}',
                        maxLines: 1,
                        style: context.textStyles.badgeNumber,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            label: '',
          ),

          ///
          /// COUNTRIES
          ///
          NavigationDestination(
            icon: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colors.grey,
              ),
              child: BalunImage(
                imageUrl: BalunIcons.globe,
                height: 24,
                width: 24,
                color: context.colors.white.withOpacity(0.25),
              ),
            ),
            selectedIcon: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colors.white,
              ),
              child: BalunImage(
                imageUrl: BalunIcons.globe,
                height: 24,
                width: 24,
                color: context.colors.black,
              ),
            ),
            label: '',
          ),

          ///
          /// SEARCH
          ///
          NavigationDestination(
            icon: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colors.grey,
              ),
              child: BalunImage(
                imageUrl: BalunIcons.search,
                height: 24,
                width: 24,
                color: context.colors.white.withOpacity(0.25),
              ),
            ),
            selectedIcon: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colors.white,
              ),
              child: BalunImage(
                imageUrl: BalunIcons.search,
                height: 24,
                width: 24,
                color: context.colors.black,
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
