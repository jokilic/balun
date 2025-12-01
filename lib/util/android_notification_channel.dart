import '../models/android_notification_channel_config/android_notification_channel_config.dart';
import '../models/notification/notification_change.dart';

/// Returns proper notification sound for `iOS`
String? getiOSSound({
  required bool playSound,
  required List<AndroidNotificationChannelConfig> channelConfigs,
  required NotificationChangeType? type,
}) {
  if (!playSound) {
    return null;
  }

  final config = getAndroidChannelConfig(
    channelConfigs: channelConfigs,
    type: type,
  );

  return '${config.soundResource}.wav';
}

/// Returns proper notification `channelId` for `Android`
String getNotificationChannelId({
  required bool playSound,
  required List<AndroidNotificationChannelConfig> channelConfigs,
  NotificationChangeType? type,
}) {
  final config = getAndroidChannelConfig(
    channelConfigs: channelConfigs,
    type: type,
  );
  final suffix = playSound ? 'sound' : 'silent';
  return '${config.baseId}_$suffix';
}

AndroidNotificationChannelConfig getAndroidChannelConfig({
  required List<AndroidNotificationChannelConfig> channelConfigs,
  required NotificationChangeType? type,
}) {
  if (type != null) {
    for (final config in channelConfigs) {
      if (config.types.contains(type)) {
        return config;
      }
    }
  }

  return channelConfigs.last;
}

String channelName({
  required AndroidNotificationChannelConfig config,
  required bool playSound,
}) => playSound ? '${config.name} (sound)' : '${config.name} (silent)';
