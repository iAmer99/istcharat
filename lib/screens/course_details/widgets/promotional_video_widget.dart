import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:istchrat/shared_components/helper_functions.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart' as yt;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../main.dart';


class PromotionalVideoWidget extends StatefulWidget {
  final String? course_link;
  final bool isVideo;
  final Function(bool) onFullScreenToggle;
  const PromotionalVideoWidget({Key? key,@required this.course_link, required this.isVideo, required this.onFullScreenToggle}) : super(key: key);

  @override
  State<PromotionalVideoWidget> createState() => _PromotionalVideoWidgetState();
}

class _PromotionalVideoWidgetState extends State<PromotionalVideoWidget> {
  late yt.YoutubePlayerController _ytController;
  bool _isPlayerReady = false;
  String route = "";
  late int _rotation;

  @override
  void initState() {
    _rotation = 0;
    if(route.isEmpty){
      route = Get.currentRoute;
    }
    print(widget.course_link);
   if(widget.isVideo) {
     _ytController = yt.YoutubePlayerController(
       initialVideoId: getVideoID(widget.course_link!),
       flags: yt.YoutubePlayerFlags(
         mute: false,
         enableCaption: false,
         autoPlay: false,
       ),
     );/*..addListener(() {
       if(_ytController.value.isFullScreen){
         widget.onFullScreenToggle(false);
       }else{
         widget.onFullScreenToggle(true);
       }
     }) */
    /* if(widget.ytController != null){
       _controller = widget.ytController!;
     }else{
       _controller = YoutubePlayerController(
         params: YoutubePlayerParams(
           showControls: true,
           showFullscreenButton: true,
         ),
       )..onInit = (){
         _controller.cueVideoById(videoId: getVideoID(widget.course_link!),);
       };
     } */
   }
   print(widget.isVideo.toString() + "testtt");
    super.initState();
  }

  @override
  void didUpdateWidget(covariant PromotionalVideoWidget oldWidget) {
    if(Get.currentRoute != route){
      _ytController.pause();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    if(widget.isVideo){
      _ytController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
       /* if(_ytController.value.isFullScreen){
          _ytController.toggleFullScreenMode();
          return false;
        }else{
          return true;
        } */
        return true;
      },
      child: RotatedBox(
        quarterTurns: _rotation,
        child: SizedBox(
          height: _rotation == 1 ? double.infinity : null,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(_rotation == 1 ? 0 : 16.h),
            child:widget.isVideo ? yt.YoutubePlayer(
              controller: _ytController,
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
                        widget.onFullScreenToggle(false);
                        _rotation = 1;
                      });
                    } else {
                      setState(() {
                        widget.onFullScreenToggle(true);
                        _rotation = 0;
                      });
                    }
                  },
                ),
              ],
            ) : Image.network(
              widget.course_link ?? "",
              fit: BoxFit.contain,
              errorBuilder: (context, _, v)=> Image.asset(
                "assets/images/no_image.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
