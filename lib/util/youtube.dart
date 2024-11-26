import 'package:url_launcher/url_launcher.dart';

Future<void> launchYouTubeVideo({required String videoId}) async {
  /// Try to launch in `YouTube` app
  final youtubeAppUrl = Uri.parse(
    'youtube://www.youtube.com/watch?v=$videoId',
  );

  if (await canLaunchUrl(youtubeAppUrl)) {
    await launchUrl(youtubeAppUrl);
  }

  /// `YouTube` app is not installed, launch in `browser`
  else {
    final youtubeBrowserUrl = Uri.parse(
      'https://www.youtube.com/watch?v=$videoId',
    );

    if (await canLaunchUrl(youtubeBrowserUrl)) {
      await launchUrl(youtubeBrowserUrl);
    }
  }
}
