import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../constants.dart';
import '../services/balun_navigation_bar_service.dart';
import '../theme/icons.dart';
import '../theme/theme.dart';
import '../util/dependencies.dart';

class BalunNavigationBar extends WatchingWidget {
  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(32),
        ),
        child: NavigationBar(
          backgroundColor: context.colors.green.withOpacity(0.5),
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
              icon: Image.asset(
                BalunIcons.ball,
                height: 26,
                width: 26,
                color: context.colors.white.withOpacity(0.2),
              ),
              selectedIcon: Image.asset(
                BalunIcons.ball,
                height: 26,
                width: 26,
                color: context.colors.white,
              ),
              label: '',
            ),

            ///
            /// COUNTRIES
            ///
            NavigationDestination(
              icon: Image.asset(
                BalunIcons.globe,
                height: 26,
                width: 26,
                color: context.colors.white.withOpacity(0.2),
              ),
              selectedIcon: Image.asset(
                BalunIcons.globe,
                height: 26,
                width: 26,
                color: context.colors.white,
              ),
              label: '',
            ),

            ///
            /// SEARCH
            ///
            NavigationDestination(
              icon: Image.asset(
                BalunIcons.search,
                height: 26,
                width: 26,
                color: context.colors.white.withOpacity(0.2),
              ),
              selectedIcon: Image.asset(
                BalunIcons.search,
                height: 26,
                width: 26,
                color: context.colors.white,
              ),
              label: '',
            ),
          ],
        ),
      );
}
