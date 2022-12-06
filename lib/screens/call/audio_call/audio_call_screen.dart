import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:istchrat/main.dart';
import 'package:istchrat/screens/bottom_nav_bar/bottom_nav_bar_screen.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:istchrat/shared_components/constants/constants.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../teacher/teacher_bottom_nav_bar/teacher_bottom_nav_bar.dart';

class AudioCallScreen extends StatefulWidget {
  const AudioCallScreen(
      {Key? key, required this.channelName, required this.name, required this.img, required this.period})
      : super(key: key);
  final String channelName;
  final String name;
  final String img;
  final int period;

  @override
  State<AudioCallScreen> createState() => _AudioCallScreenState();
}

class _AudioCallScreenState extends State<AudioCallScreen> {
  final String appID = "76ddb634de1b417c8cbf95a74fd9ba0a";

  bool _joined = false;
  int _remoteUid = 0;

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
      setState(() {
        _remoteUid = 0;
      });
      if (box.read(Constants.role.toString()) == "lecturer") {
        Get.offAll(() => TeacherBottomNavBarScreen());
      } else {
        Get.offAll(() => BottomNavBarScreen());
      }
    }));
    // Join channel with channel name as 123
    await engine.enableAudio();
    await engine.joinChannel(null, widget.channelName, null,
        box.read(Constants.id.toString()));
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
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/callbg.png'), fit: BoxFit.cover),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 200.h,
                  width: 200.w,
                  margin: EdgeInsetsDirectional.only(
                      top: 70.0, start: 50.w, end: 50.w, bottom: 30.h),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      color: Colors.transparent,
                      shape: BoxShape.circle),
                  child: Container(
                    height: 150.h,
                    width: 150.w,
                    margin: const EdgeInsets.all(30.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(widget.img),
                      maxRadius: 80.w,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.white),
                        color: Colors.transparent,
                        shape: BoxShape.circle),
                  ),
                ),
                Text(
                  widget.name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "$hours:$minutes:$seconds",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 180.h,
                ),
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
                          SizedBox(
                            height: 5.h,
                          ),
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
                    SizedBox(
                      width: 20.w,
                    ),
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
                          SizedBox(
                            height: 5.h,
                          ),
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
                SizedBox(
                  height: 40.h,
                ),
                GestureDetector(
                  onTap: () async {
                    await engine.leaveChannel();
                    await engine.destroy();
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
