import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Builds a side-by-side crest image for Android notifications.
Future<BigPictureStyleInformation?> buildAndroidTeamLogosBigPicture({
  required Dio dio,
  required String? homeLogoUrl,
  required String? awayLogoUrl,
  int targetHeight = 128,
}) async {
  final homeBytes = await downloadImageBytes(dio, homeLogoUrl);
  final awayBytes = await downloadImageBytes(dio, awayLogoUrl);

  if (homeBytes == null || awayBytes == null) {
    return null;
  }

  final mergedPng = composeSideBySidePng(
    homeBytes: homeBytes,
    awayBytes: awayBytes,
    targetHeight: targetHeight,
  );

  if (mergedPng == null) {
    return null;
  }

  final bitmap = ByteArrayAndroidBitmap(mergedPng);

  return BigPictureStyleInformation(
    bitmap,
    hideExpandedLargeIcon: true,
    htmlFormatContent: true,
    htmlFormatTitle: true,
  );
}

/// Downloads team logos to temp storage and returns iOS notification attachments
Future<List<DarwinNotificationAttachment>> buildIosTeamLogoAttachments({
  required Dio dio,
  required String? homeLogoUrl,
  required String? awayLogoUrl,
  int targetHeight = 256,
}) async {
  final attachments = <DarwinNotificationAttachment>[];

  final tempDir = await getTemporaryDirectory();
  final timestamp = DateTime.now().millisecondsSinceEpoch;

  Future<void> addAttachment(String? url, String label) async {
    final bytes = await downloadImageBytes(dio, url);
    if (bytes == null) {
      return;
    }

    final pngBytes = ensurePng(
      bytes,
      targetHeight: targetHeight,
    );
    if (pngBytes == null) {
      return;
    }

    final path = p.join(
      tempDir.path,
      'balun_${label}_$timestamp.png',
    );
    final file = File(path);
    await file.writeAsBytes(
      pngBytes,
      flush: true,
    );
    attachments.add(
      DarwinNotificationAttachment(path),
    );
  }

  await addAttachment(homeLogoUrl, 'home');
  await addAttachment(awayLogoUrl, 'away');

  return attachments;
}

Future<Uint8List?> downloadImageBytes(Dio dio, String? url) async {
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
  );

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
