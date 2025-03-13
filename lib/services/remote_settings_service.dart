import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../constants.dart';
import '../models/remote_settings/remote_settings_response.dart';
import '../util/isolates.dart';
import 'logger_service.dart';

class RemoteSettingsService extends ValueNotifier<({bool mixLogos, bool mixNames, bool hideHighlights})> {
  final LoggerService logger;
  final Dio dio;
  final InternetConnection internetConnection;

  RemoteSettingsService({
    required this.logger,
    required this.dio,
    required this.internetConnection,
  }) : super((mixLogos: false, mixNames: false, hideHighlights: false));

  ///
  /// INIT
  ///

  Future<void> init() async {
    final remoteSettings = await getRemoteSettings();

    if (remoteSettings.remoteSettingsResponse != null && remoteSettings.error == null) {
      final settings = remoteSettings.remoteSettingsResponse!;
      value = (
        mixLogos: settings.mixLogos,
        mixNames: settings.mixNames,
        hideHighlights: settings.hideHighlights,
      );
    } else {
      value = (
        mixLogos: false,
        mixNames: false,
        hideHighlights: false,
      );
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
      final error = await handleCatch(
        methodName: 'getRemoteSettings',
        mainError: '$e',
      );

      return (remoteSettingsResponse: null, error: error);
    }
  }

  /// Checks for internet connection and returns error message
  Future<String> handleCatch({
    required String methodName,
    required String mainError,
  }) async {
    final hasInternet = await internetConnection.hasInternetAccess;
    final generatedError = hasInternet ? mainError : 'Internet connection error';
    final error = 'API -> $methodName -> catch -> $generatedError';
    logger.e(error);
    return error;
  }
}
