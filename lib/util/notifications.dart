import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Builds teams image for Android `largeIcon`
Future<ByteArrayAndroidBitmap?> buildAndroidNotificationTeamLogos({
  required Dio dio,
  required String? homeLogoUrl,
  required String? awayLogoUrl,
  int targetHeight = 128,
}) async {
  final homeBytes = await downloadImageBytes(
    dio: dio,
    url: homeLogoUrl,
  );
  final awayBytes = await downloadImageBytes(
    dio: dio,
    url: awayLogoUrl,
  );

  if (homeBytes == null || awayBytes == null) {
    return null;
  }

  final mergedPng = composeSideBySidePng(
    homeBytes: homeBytes,
    awayBytes: awayBytes,
    targetHeight: targetHeight,
    backgroundColor: img.ColorRgba8(255, 255, 255, 255),
  );

  if (mergedPng == null) {
    return null;
  }

  return ByteArrayAndroidBitmap(mergedPng);
}

/// Builds a single combined crest attachment for iOS with transparent background
Future<List<DarwinNotificationAttachment>> buildiOSNotificationTeamLogos({
  required Dio dio,
  required String? homeLogoUrl,
  required String? awayLogoUrl,
  int targetHeight = 256,
}) async {
  final attachments = <DarwinNotificationAttachment>[];

  final tempDir = await getTemporaryDirectory();
  final timestamp = DateTime.now().millisecondsSinceEpoch;

  final homeBytes = await downloadImageBytes(
    dio: dio,
    url: homeLogoUrl,
  );
  final awayBytes = await downloadImageBytes(
    dio: dio,
    url: awayLogoUrl,
  );

  if (homeBytes == null || awayBytes == null) {
    return attachments;
  }

  final mergedPng = composeSideBySidePng(
    homeBytes: homeBytes,
    awayBytes: awayBytes,
    targetHeight: targetHeight,
    backgroundColor: img.ColorRgba8(255, 255, 255, 0),
  );

  if (mergedPng == null) {
    return attachments;
  }

  final path = p.join(
    tempDir.path,
    'balun_logos_combined_$timestamp.png',
  );
  final file = File(path);
  await file.writeAsBytes(
    mergedPng,
    flush: true,
  );
  attachments.add(
    DarwinNotificationAttachment(path),
  );

  return attachments;
}

Future<Uint8List?> downloadImageBytes({
  required Dio dio,
  required String? url,
}) async {
  if (url?.isEmpty ?? true) {
    return null;
  }

  try {
    final response = await dio.get<List<int>>(
      url!,
      options: Options(
        responseType: ResponseType.bytes,
      ),
    );

    if (response.statusCode != 200 || response.data == null) {
      return null;
    }

    return Uint8List.fromList(response.data!);
  } catch (_) {
    return null;
  }
}

Uint8List? composeSideBySidePng({
  required Uint8List homeBytes,
  required Uint8List awayBytes,
  required int targetHeight,
  img.Color? backgroundColor,
}) {
  final homeImage = img.decodeImage(homeBytes);
  final awayImage = img.decodeImage(awayBytes);

  if (homeImage == null || awayImage == null || targetHeight <= 0) {
    return null;
  }

  final resizedHome = img.copyResize(
    homeImage,
    height: targetHeight,
  );
  final resizedAway = img.copyResize(
    awayImage,
    height: targetHeight,
  );

  final canvas = img.Image(
    width: resizedHome.width + resizedAway.width,
    height: targetHeight,
    numChannels: 4,
  );

  /// Fill background to avoid default black
  /// Pass transparent for iOO
  /// White for Android `largeIcon`
  if (backgroundColor != null) {
    img.fill(
      canvas,
      color: backgroundColor,
    );
  }

  img.compositeImage(
    canvas,
    resizedHome,
    dstX: 0,
    dstY: 0,
    blend: img.BlendMode.direct,
  );

  img.compositeImage(
    canvas,
    resizedAway,
    dstX: resizedHome.width,
    dstY: 0,
    blend: img.BlendMode.direct,
  );

  return Uint8List.fromList(
    img.encodePng(canvas),
  );
}

Uint8List? ensurePng(
  Uint8List bytes, {
  int? targetHeight,
}) {
  final decoded = img.decodeImage(bytes);
  if (decoded == null) {
    return null;
  }

  final processed = targetHeight != null && targetHeight > 0 ? img.copyResize(decoded, height: targetHeight) : decoded;
  return Uint8List.fromList(
    img.encodePng(processed),
  );
}
