import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../constants.dart';

class AboutVideoWidget extends StatefulWidget {
  @override
  _AboutVideoWidgetState createState() => _AboutVideoWidgetState();
}

class _AboutVideoWidgetState extends State<AboutVideoWidget> {
  late final VideoPlayerController videoController;

  Future<void> initVideo() async {
    videoController = VideoPlayerController.asset(BalunConstants.josipVideo);
    await videoController.initialize();
    await videoController.setLooping(true);
    await videoController.setVolume(0);
    await videoController.play();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initVideo();
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => videoController.value.isInitialized
      ? AspectRatio(
          aspectRatio: videoController.value.aspectRatio,
          child: VideoPlayer(videoController),
        )
      : const SizedBox.shrink();
}
