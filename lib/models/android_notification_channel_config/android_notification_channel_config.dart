import 'package:flutter/foundation.dart';

import '../notification/notification_change.dart';

class AndroidNotificationChannelConfig {
  final String baseId;
  final String name;
  final String description;
  final String soundResource;
  final Set<NotificationChangeType> types;

  AndroidNotificationChannelConfig({
    required this.baseId,
    required this.name,
    required this.description,
    required this.soundResource,
    required this.types,
  });

  @override
  String toString() => 'AndroidNotificationChannelConfig(baseId: $baseId, name: $name, description: $description, soundResource: $soundResource, types: $types)';

  @override
  bool operator ==(covariant AndroidNotificationChannelConfig other) {
    if (identical(this, other)) {
      return true;
    }

    return other.baseId == baseId && other.name == name && other.description == description && other.soundResource == soundResource && setEquals(other.types, types);
  }

  @override
  int get hashCode => baseId.hashCode ^ name.hashCode ^ description.hashCode ^ soundResource.hashCode ^ types.hashCode;
}
