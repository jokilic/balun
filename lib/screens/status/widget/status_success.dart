import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../models/status/status_inner_response.dart';
import '../../../theme/icons.dart';
import 'status_list_tile.dart';
import 'status_static_widget_list.dart';

class StatusSuccess extends StatelessWidget {
  final StatusInnerResponse status;

  const StatusSuccess({
    required this.status,
  });

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
    physics: const BouncingScrollPhysics(),
    children: [
      ...getStatusStaticWidgetList(context),

      ///
      /// ACCOUNT
      ///
      StatusListTile(
        icon: BalunIcons.account,
        title: '${status.account?.firstName} ${status.account?.lastName}',
        subtitle: status.account?.email ?? '--',
      ),

      ///
      /// SUBSCRIPTION
      ///
      StatusListTile(
        icon: BalunIcons.subscription,
        title: (status.subscription?.active ?? false) ? '${status.subscription?.plan} ${'statusSubscription'.tr()}' : 'statusSubscriptionNotActive'.tr(),
        subtitle: status.subscription?.end != null
            ? '${'statusExpires'.tr()} ${DateFormat(
                'd. MMMM y.',
                context.locale.toLanguageTag(),
              ).format(status.subscription!.end!)}'
            : null,
      ),

      ///
      /// REQUESTS
      ///
      StatusListTile(
        icon: BalunIcons.requests,
        title: 'statusRequests'.tr(),
        subtitle: '${status.requests?.current} / ${status.requests?.limitDay}',
      ),

      const SizedBox(height: 28),
    ],
  );
}
