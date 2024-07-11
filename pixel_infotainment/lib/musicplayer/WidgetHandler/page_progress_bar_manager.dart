import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

class UpdateSongProgress extends StatelessWidget {
  final AudioPlayer audioPlayer;
  final bool isSongLoaded;
  final bool isSongPlaying;

  UpdateSongProgress(
      {required this.audioPlayer,
      required this.isSongLoaded,
      required this.isSongPlaying});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 695,
      left: 230,
      width: 968,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: StreamBuilder(
            stream: audioPlayer.positionStream,
            builder: (context, snapshot1) {
              final Duration duration = isSongLoaded
                  ? snapshot1.data as Duration
                  : const Duration(seconds: 0);
              return StreamBuilder(
                  stream: audioPlayer.bufferedPositionStream,
                  builder: (context, snapshot2) {
                    final Duration bufferedDuration = isSongLoaded
                        ? snapshot2.data as Duration
                        : const Duration(seconds: 0);
                    return SizedBox(
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ProgressBar(
                          barHeight: 43,
                          progress: duration,
                          total: audioPlayer.duration ??
                              const Duration(seconds: 0),
                          buffered: bufferedDuration,
                          timeLabelPadding: -1,
                          timeLabelTextStyle: const TextStyle(
                              fontSize: 18, color: Colors.white),
                          progressBarColor: const Color(0xFF2C5E89),
                          baseBarColor: Colors.grey[200],
                          bufferedBarColor: Colors.grey[200],
                          thumbColor: const Color(0xFF2C5E89),
                          onSeek: isSongLoaded
                              ? (duration) async {
                                  await audioPlayer.seek(duration);
                                }
                              : null,
                        ),
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
