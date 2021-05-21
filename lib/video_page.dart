import 'dart:io';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  final String media;

  const VideoPlayerPage({
    Key? key,
    required this.media,
  }) : super(key: key);

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _playerController;
  late FlickManager _flickManager;

  @override
  void initState() {
    _playerController = VideoPlayerController.file(File(widget.media));
    _flickManager = FlickManager(videoPlayerController: _playerController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlickVideoPlayer(
        flickManager: _flickManager,
      ),
    );
  }

  @override
  void dispose() {
    _flickManager.dispose();
    super.dispose();
  }
}
