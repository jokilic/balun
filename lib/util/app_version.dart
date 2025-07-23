import 'package:package_info_plus/package_info_plus.dart';

/// Return app version number
Future<String?> getAppVersion() async {
  try {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  } catch (e) {
    return null;
  }
}
