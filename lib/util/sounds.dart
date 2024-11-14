import 'package:just_audio/just_audio.dart';

/// Plays the `Welcome to Balun` sound
Future<void> playWelcomeToBalun() async {
  final player = AudioPlayer();
  await player.setAsset(
    'assets/audio/welcome_to_balun.mp3',
  );
  await player.play();
  await player.dispose();
}
