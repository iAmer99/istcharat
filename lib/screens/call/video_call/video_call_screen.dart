import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

import '../../../main.dart';
import '../../../shared_components/colors.dart';
import '../../../shared_components/constants/constants.dart';
import '../../bottom_nav_bar/bottom_nav_bar_screen.dart';
import '../../teacher/teacher_bottom_nav_bar/teacher_bottom_nav_bar.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({Key? key, required this.channelName, required this.period}) : super(key: key);
  final String channelName;
  final int period;

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {

  final bool test = true;
  final String appID = "76ddb634de1b417c8cbf95a74fd9ba0a";

  bool _joined = false;
  int _remoteUid = 0;
bool _switch = true;
  bool _isSpeakerOn = false;
  bool _muted = false;
  late RtcEngine engine;
  Timer? countdownTimer;
  late Duration myDuration;
  String minutes = "00";
  String seconds = "00";
  String hours = "00";

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }
  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        stopTimer();
        if (box.read(Constants.role.toString()) == "lecturer") {
          Get.offAll(() => TeacherBottomNavBarScreen());
        } else {
          Get.offAll(() => BottomNavBarScreen());
        }
      } else {
        myDuration = Duration(seconds: seconds);
      }
      hours = strDigits(myDuration.inHours.remainder(60));
      minutes = strDigits(myDuration.inMinutes.remainder(60));
      this.seconds = strDigits(myDuration.inSeconds.remainder(60));
    });
  }

  String strDigits(int n) => n.toString().padLeft(2, '0');

  Future<void> initAgora() async {
    await [Permission.camera, Permission.microphone].request();

    // Create RTC client instance
    RtcEngineContext context = RtcEngineContext(appID);
    engine = await RtcEngine.createWithContext(context);
    // Define event handling logic
    engine.setEventHandler(RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          print('joinChannelSuccess ${channel} ${uid}');
          setState(() {
            _joined = true;
          });
        }, userJoined: (int uid, int elapsed) {
      print('userJoined ${uid}');
      setState(() {
        _remoteUid = uid;
      });
    }, userOffline: (int uid, UserOfflineReason reason) {
      print('userOffline ${uid}');
      if(box.read(Constants.role.toString()) == "lecturer" ){
        Get.offAll(() => TeacherBottomNavBarScreen());
      }else{
        Get.offAll(() => BottomNavBarScreen());
      }
      setState(() {
        _remoteUid = 0;
      });
    }));
    await engine.enableVideo();
    // Join channel with channel name as 123
    await engine.joinChannel(null, widget.channelName, null,  box.read(Constants.id.toString()));
  }

  @override
  void initState() {
    myDuration = Duration(minutes: widget.period);
    initAgora();
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
     engine.leaveChannel();
     engine.destroy();
     stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async {
        return false;
      },
      child: SafeArea(child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/callbg.png'),
                fit: BoxFit.cover),
          ),
          child: Stack(
            children: [
              Center(
                child: _switch ? _renderRemoteVideo() : _renderLocalPreview(),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: 100,
                  height: 100,
                  color: mainColor,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _switch = !_switch;
                      });
                    },
                    child: Center(
                      child: _switch ? _renderLocalPreview() : _renderRemoteVideo(),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 40.h),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(20.h),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 14.w),
                    child: Text(
                      "$hours:$minutes:$seconds",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 40.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isSpeakerOn = !_isSpeakerOn;
                              });
                              engine.setEnableSpeakerphone(_isSpeakerOn);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              //mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 50.w,
                                  width: 50.w,
                                  decoration: const BoxDecoration(
                                    color: Color(0xff555464),
                                    shape: BoxShape.circle,
                                  ),
                                  child: _isSpeakerOn
                                      ? const Icon(
                                    Icons.volume_up,
                                    color: Colors.white,
                                  )
                                      : const Icon(
                                    Icons.volume_down,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 5.h,),
                                Text(
                                  "Speaker",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20.w,),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _muted = !_muted;
                              });
                              engine.muteLocalAudioStream(_muted);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 50.w,
                                  width: 50.w,
                                  decoration: const BoxDecoration(
                                    color: Color(0xff555464),
                                    shape: BoxShape.circle,
                                  ),
                                  child: _muted
                                      ? const Icon(
                                    Icons.mic_off,
                                    color: Colors.white,
                                  )
                                      : const Icon(
                                    Icons.mic,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 5.h,),
                                Text(
                                  "Mute",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h,),
                      GestureDetector(
                        onTap: () {
                          engine.leaveChannel();
                          engine.destroy();
                          if (box.read(Constants.role.toString()) == "lecturer") {
                            Get.offAll(() => TeacherBottomNavBarScreen());
                          } else {
                            Get.offAll(() => BottomNavBarScreen());
                          }
                        },
                        child: Container(
                          child: const Icon(
                            Icons.call_end_outlined,
                            color: Colors.white,
                          ),
                          width: 60.w,
                          height: 60.h,
                          margin: EdgeInsets.all(10.0),
                          decoration:
                          BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ) ,
        ),
      )),
    );
  }

  // Local preview
  Widget _renderLocalPreview() {
    if (_joined) {
      return const RtcLocalView.SurfaceView();
    } else {
      return const Text(
        'Please join channel first',
        textAlign: TextAlign.center,
      );
    }
  }

  // Remote preview
  Widget _renderRemoteVideo() {
    if (_remoteUid != 0) {
      return RtcRemoteView.SurfaceView(
        uid: _remoteUid,
        channelId: widget.channelName,
      );
    } else {
      return const Text(
        'Please wait remote user join',
        textAlign: TextAlign.center,
      );
    }
  }
}
