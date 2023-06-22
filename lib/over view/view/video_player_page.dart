import 'dart:developer';
import 'dart:io';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Video Player Widget',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Video Player Widget'),
//         ),
//         body: Center(
//           child: VideoPlayerWidget(
//             videoUrl: 'https://example.com/video.mp4',
//           ),
//         ),
//       ),
//     );
//   }
// }

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  VideoPlayerWidget({required this.videoUrl});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.file(File(widget.videoUrl)),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log(widget.videoUrl.toString());
    return FlickVideoPlayer(
 
      flickManager: flickManager,
    );
  }
}
