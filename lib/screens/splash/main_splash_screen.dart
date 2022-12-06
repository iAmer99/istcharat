import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:istchrat/screens/bottom_nav_bar/bottom_nav_bar_screen.dart';
import 'package:istchrat/screens/bottom_nav_bar/favourite_screen/favourite_screen.dart';
import 'package:istchrat/screens/intro/onboarding_screen.dart';
import 'package:istchrat/screens/login/login_screen.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:istchrat/shared_components/constants/constants.dart';

import '../../main.dart';
import '../teacher/teacher_bottom_nav_bar/teacher_bottom_nav_bar.dart';

class MainSplashScreen extends StatefulWidget {
  MainSplashScreen({Key? key}) : super(key: key);

  @override
  State<MainSplashScreen> createState() => _MainSplashScreenState();
}

class _MainSplashScreenState extends State<MainSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Timer _timer;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    Timer(Duration(seconds: 1), () {
      _controller.forward();
      _timer = Timer(Duration(seconds: 2), () {
        if (Get.currentRoute != "/AudioCallScreen" &&
            Get.currentRoute != "/VideoCallScreen" &&
            Get.currentRoute != "/DialingScreen" &&
            Get.currentRoute != "/ChatScreen" &&
            Get.currentRoute != "/BottomNavBarScreen" &&
            Get.currentRoute != "/TeacherBottomNavBarScreen") {
          Get.offAll(() => OnBoardingScreen());
         /* box.read("has_opened") ?? false
              ? (box.read(Constants.role.toString()) == "lecturer"
                  ? Get.offAll(() => TeacherBottomNavBarScreen())
                  : Get.offAll(() => BottomNavBarScreen()))
              : */
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: splashColor,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(top: 50.h),
            child: Image.asset(
              "assets/images/splash_picture.png",
            ),
          ),
        ),
      ),
    );
  }
}
