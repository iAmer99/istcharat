import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:istchrat/custom_widgets/custom_dialogs/failed_dialog/failed_dialog.dart';
import 'package:istchrat/screens/call/audio_call/audio_call_screen.dart';
import 'package:istchrat/screens/call/video_call/video_call_screen.dart';
import 'package:istchrat/screens/dialing/cubit/dialing_cubit.dart';
import 'package:istchrat/screens/dialing/cubit/dialing_states.dart';

import '../../main.dart';
import '../../shared_components/constants/constants.dart';
import '../bottom_nav_bar/bottom_nav_bar_screen.dart';
import '../teacher/teacher_bottom_nav_bar/teacher_bottom_nav_bar.dart';

class DialingScreen extends StatefulWidget {
  DialingScreen(
      {Key? key,
      required this.isVideo,
      this.isLecturer = true,
      required this.id,
      required this.categoryKey,
      this.period,
      required this.pic,
      this.channelName,
      required this.name})
      : super(key: key);
  final bool isVideo;
  final bool isLecturer;
  final String id;
  final String categoryKey;
  final String name;
  String pic;
  String? channelName;
  String? period;

  @override
  State<DialingScreen> createState() => _DialingScreenState();
}

class _DialingScreenState extends State<DialingScreen> {
  @override
  void initState() {
    FlutterRingtonePlayer.playRingtone();
    super.initState();
  }

  @override
  void dispose() {
    FlutterRingtonePlayer.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DialingCubit()
        ..startCall(
            id: widget.id,
            key: widget.categoryKey,
            isLecturer: widget.isLecturer),
      child: BlocConsumer<DialingCubit, DialingStates>(
        listener: (context, state) {
          if (state is DialingCallFailedState) {
            FlutterRingtonePlayer.stop();
            failedDialog(context: context, message: state.errorMsg, onCancel: (){
              Get.back();
            });
          } else if (state is DialingRejectedState ||
              state is DialingCallEndedState) {
            FlutterRingtonePlayer.stop();
            if (box.read(Constants.role.toString()) == "lecturer") {
              Get.offAll(() => TeacherBottomNavBarScreen());
            } else {
              Get.offAll(() => BottomNavBarScreen());
            }
          } else if (state is DialingAcceptedState) {
            FlutterRingtonePlayer.stop();
            widget.isVideo
                ? Get.offAll(() => VideoCallScreen(
                      channelName: widget.channelName!,
              period: int.tryParse(widget.period?? "0") ?? 0,
                    ))
                : Get.offAll(() => AudioCallScreen(
                      channelName: widget.channelName!,
                      name: widget.name,
                      period: int.tryParse(widget.period ?? "0") ?? 0,
                      img: widget.pic,
                    ));
          }
        },
        builder: (context, state) {
          final cubit = DialingCubit.get(context);
          if (widget.pic.isEmpty) {
            widget.pic = cubit.img;
          }
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
                      image: AssetImage('assets/images/callbg.png'),
                      fit: BoxFit.cover),
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
                          margin: EdgeInsets.all(30.0),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(widget.pic.isEmpty
                                ? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__480.png"
                                : widget.pic),
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
                        widget.isVideo ? "Video Call" : "Audio Call",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 80.h,
                      ),
                      SizedBox(
                        height: 150.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (!widget.isLecturer)
                            GestureDetector(
                              onTap: () {
                                FlutterRingtonePlayer.stop();
                                cubit.acceptOrCancel(
                                    id: widget.id,
                                    key: widget.categoryKey,
                                    status: "accept");
                              },
                              child: Container(
                                child: Icon(
                                  Icons.call,
                                  color: Colors.white,
                                ),
                                width: 80.w,
                                height: 80.h,
                                margin: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    color: Colors.teal, shape: BoxShape.circle),
                              ),
                            ),
                          GestureDetector(
                            onTap: () {
                              FlutterRingtonePlayer.stop();
                              if (!widget.isLecturer) {
                                cubit.acceptOrCancel(
                                    id: widget.id,
                                    key: widget.categoryKey,
                                    status: "decline");
                              } else {
                                cubit.endCall(
                                    id: widget.id, key: widget.categoryKey);
                              }
                            },
                            child: Container(
                              child: const Icon(
                                Icons.call_end_outlined,
                                color: Colors.white,
                              ),
                              width: 80.w,
                              height: 80.h,
                              margin: const EdgeInsets.all(10.0),
                              decoration: const BoxDecoration(
                                  color: Colors.red, shape: BoxShape.circle),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
