import 'package:flutter/material.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:video_player/video_player.dart';

import 'player_controllers_row.dart';

class VideoPlayerWidget extends StatefulWidget {

  VideoPlayerWidget({this.url});

  String? url ;

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
     String url =
         "https://drive.google.com/uc?export=download&id=1E7wCXNTm1R7TD3FFT6BpOvMrjPoDMIz7";
    _controller = VideoPlayerController.network(url);
    _controller.initialize().then((_) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                VideoPlayer(_controller),
                PlayerControllerRow(controller: _controller),
              ],
            ),
          )
        : _controller.value.isBuffering
            ? const CircularProgressIndicator(
                color: mainColor,
              )
            : Container();
  }
}
