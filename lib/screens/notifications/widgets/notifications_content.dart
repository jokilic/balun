import 'package:flutter/material.dart';

import '../../../models/notification/notification_settings.dart';

class NotificationsContent extends StatelessWidget {
  final NotificationSettings notificationsState;

  const NotificationsContent({
    required this.notificationsState,
  });

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
    physics: const BouncingScrollPhysics(),
    children: [],
  );
}
