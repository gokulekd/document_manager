
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AudioPlayerWidget extends StatefulWidget {
  String filePath;
  String title;
  AudioPlayerWidget({super.key, required this.filePath, required this.title});

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late AudioPlayer audioPlayer;
  bool isPlaying = false;
  double sliderValue = 0.0;
  double maxDuration = 0.0;
  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        maxDuration = duration.inMilliseconds.toDouble();
      });
    });

    audioPlayer.onPositionChanged.listen((Duration position) {
      setState(() {
        sliderValue = position.inMilliseconds.toDouble();
      });
    });
  }

  @override
  void dispose() {
    audioPlayer.release();
    audioPlayer.dispose();
    super.dispose();
  }

  void playSong() async {
    await audioPlayer.play(DeviceFileSource(widget.filePath));
    setState(() {
      isPlaying = true;
    });
  }

  void pauseSong() async {
    await audioPlayer.pause();

    setState(() {
      isPlaying = false;
    });
  }

  void seekTo(double value) {
    setState(() {
      audioPlayer.seek(Duration(milliseconds: value.round()));
    });
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Music Player"),
              const SizedBox(
                height: 40,
              ),
         
              Slider(
                value: sliderValue.toDouble(),
                min: 0,
                max: maxDuration.toDouble(),
                onChanged: (double value) {
                  setState(() {
                    seekTo(value);
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatDuration(
                      Duration(milliseconds: sliderValue.round()))),
                  Text(formatDuration(
                      Duration(milliseconds: maxDuration.round()))),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blue),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(40)),
                  child: IconButton(
                    icon: Icon(
                      !isPlaying ? Icons.play_arrow : Icons.pause,
                      size: 20,
                      color: Colors.white,
                    ),
                    onPressed: isPlaying ? pauseSong : playSong,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
