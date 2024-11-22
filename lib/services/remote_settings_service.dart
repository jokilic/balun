import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/remote_settings/remote_settings_response.dart';
import '../util/isolates.dart';
import 'logger_service.dart';

class RemoteSettingsService extends ValueNotifier<({bool mixLogos, bool mixNames})> {
  final LoggerService logger;
  final Dio dio;

  RemoteSettingsService({
    required this.logger,
    required this.dio,
  }) : super((mixLogos: false, mixNames: false));

  ///
  /// INIT
  ///

  Future<void> init() async {
    final remoteSettings = await getRemoteSettings();

    if (remoteSettings.remoteSettingsResponse != null && remoteSettings.error == null) {
      final settings = remoteSettings.remoteSettingsResponse!;
      value = (mixLogos: settings.mixLogos, mixNames: settings.mixNames);
    } else {
      value = (mixLogos: false, mixNames: false);
    }
  }

  ///
  /// METHODS
  ///

  Future<({RemoteSettingsResponse? remoteSettingsResponse, String? error})> getRemoteSettings() async {
    try {
      final response = await dio.get(
        BalunConstants.remoteSettingsJsonUrl,
      );

      /// Handle status codes
      switch (response.statusCode) {
        /// Response is successful
        case 200:
        case 304:
          try {
            final parsedResponse = await computeRemoteSettings(response.data);
            return (remoteSettingsResponse: parsedResponse, error: null);
          } catch (e) {
            final error = 'API -> getRemoteSettings -> parsing error -> $e';
            logger.e(error);
            return (remoteSettingsResponse: null, error: error);
          }

        /// Response is not successful
        default:
          final error = 'API -> getRemoteSettings -> StatusCode ${response.statusCode}';
          logger.e(error);
          return (remoteSettingsResponse: null, error: error);
      }
    } catch (e) {
      final error = 'API -> getRemoteSettings -> catch -> $e';
      logger.e(error);
      return (remoteSettingsResponse: null, error: error);
    }
  }
}
