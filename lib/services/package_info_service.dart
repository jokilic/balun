import 'package:package_info_plus/package_info_plus.dart';

import 'logger_service.dart';

class PackageInfoService {
  final LoggerService logger;

  PackageInfoService({
    required this.logger,
  });

  ///
  /// VARIABLES
  ///

  late final String appNameAndVersion;

  ///
  /// INIT
  ///

  Future<void> init() async {
    final packageInfo = await PackageInfo.fromPlatform();
    appNameAndVersion = '${packageInfo.appName[0].toUpperCase()}${packageInfo.appName.substring(1)} v${packageInfo.version}';
  }
}
