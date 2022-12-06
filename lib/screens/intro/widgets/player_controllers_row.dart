import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:video_player/video_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

class PlayerControllerRow extends StatefulWidget {
  const PlayerControllerRow({Key? key, required this.controller})
      : super(key: key);
  final VideoPlayerController controller;

  @override
  State<PlayerControllerRow> createState() => _PlayerControllerRowState();
}

class _PlayerControllerRowState extends State<PlayerControllerRow> {
  @override
  void initState() {
    widget.controller.addListener(() {
      setState(() {

      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: SizedBox(
        width: double.infinity,
        // height: 15 * heightMultiplier,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ProgressBar(
              total: widget.controller.value.duration,
              progress: widget.controller.value.position,
              onSeek: (value) {
                widget.controller.seekTo(value);
              },
              progressBarColor: mainColor,
              thumbColor: mainColor,
              baseBarColor: Colors.white24,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 5.w, vertical: 5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          widget.controller.value.isPlaying
                              ? widget.controller.pause()
                              : widget.controller.play();
                        },
                        child: Container(
                          height: 30.w,
                          width: 30.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff3a4854),
                          ),
                          child: Center(
                              child: Icon(
                            widget.controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.white,
                            size: 20.w,
                          )),
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
