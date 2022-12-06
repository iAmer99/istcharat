import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:istchrat/screens/intro/widgets/video_player_widget.dart';
import 'package:istchrat/shared_components/helper_functions.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../shared_components/colors.dart';

class FirstSplash extends StatefulWidget {

  FirstSplash({this.videoUrl, this.imgUrl, required this.isFullScreen, required this.onFullScreenToggle});

  String? videoUrl;
  String? imgUrl;
  final bool isFullScreen;
  final Function(bool) onFullScreenToggle;

  @override
  State<FirstSplash> createState() => _FirstSplashState();
}

class _FirstSplashState extends State<FirstSplash> {

  late YoutubePlayerController _controller;
  late int _rotation;

  @override
  void initState() {
    if(widget.videoUrl != null) _controller =  YoutubePlayerController(
      initialVideoId: getVideoID(widget.videoUrl!),
      flags: YoutubePlayerFlags(
        mute: false,
        enableCaption: false,
        autoPlay: false,
      ),
    );
    _rotation = 0;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
      /*if(_controller.value.isFullScreen){
        _controller.toggleFullScreenMode();
        return false;
      }else{
        return true;
      } */
      return true;
      },
      child: Scaffold(
          body: SizedBox(
            width: double.infinity,
            height: Get.height,
            child: Stack(
        children: [
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                "assets/images/splash1.png",
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal:widget.isFullScreen ? 0 : 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height:  _rotation == 0 ? null : Get.height,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          height: 270.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.h),
                          ),
                        ),
                      if(widget.videoUrl != null)  RotatedBox(
                        quarterTurns: _rotation,
                        child: SizedBox(
                          width: double.infinity,
                          height: _rotation == 0 ? null : Get.height,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(widget.isFullScreen ? 0 : 40.h),
                              child: YoutubePlayer(
                                controller: _controller,
                                showVideoProgressIndicator: true,
                                bottomActions: [
                                  CurrentPosition(),
                                  ProgressBar(isExpanded: true),
                                  RemainingDuration(),
                                  IconButton(
                                    icon: Icon(
                                      _rotation == 0 ? Icons.fullscreen : Icons.fullscreen_exit,
                                      color: Colors.white,
                                    ),
                                    onPressed: () async {
                                      if (_rotation == 0) {
                                        setState(() {
                                          widget.onFullScreenToggle(true);
                                          _rotation = 1;
                                        });
                                      } else {
                                        setState(() {
                                          widget.onFullScreenToggle(false);
                                          _rotation = 0;
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ),
                        if(widget.imgUrl != null && widget.videoUrl == null) Image.network(
                          widget.imgUrl!,
                          height: 244.h,
                        ),
                      ],
                    ),
                  ),
                 if(!widget.isFullScreen) SizedBox(
                    height: 25,
                  ),
                  if(!widget.isFullScreen) Text(
                    "استشاري نفسي و تربوي و من رواد",
                    style: TextStyle(fontSize: 19, color: Colors.white),
                  ),
                  if(!widget.isFullScreen)  Text(
                    "العالم العربي",
                    style: TextStyle(fontSize: 19, color: Colors.white),
                  ),
                ],
              ),
            ),
        ],
      ),
          )),
    );
  }
}
