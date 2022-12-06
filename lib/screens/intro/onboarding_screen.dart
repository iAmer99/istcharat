import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:istchrat/main.dart';
import 'package:istchrat/screens/bottom_nav_bar/bottom_nav_bar_screen.dart';
import 'package:istchrat/screens/call/video_call/video_call_screen.dart';
import 'package:istchrat/screens/intro/domain/IntroModel.dart';
import 'package:istchrat/screens/intro/first_splash.dart';
import 'package:istchrat/screens/intro/intro_cubit/intro_cubit.dart';
import 'package:istchrat/screens/intro/intro_cubit/intro_states.dart';
import 'package:istchrat/screens/login/login_screen.dart';
import 'package:istchrat/screens/teacher/teacher_bottom_nav_bar/teacher_bottom_nav_bar.dart';
import 'package:istchrat/shared_components/constants/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isFullScreen = false;

  final controller = PageController(keepPage: true);

  List<Rows>? introList = [];

  IntroCubit? introCubit;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IntroCubit()..getIntroData(),
      child: BlocConsumer<IntroCubit, IntroStates>(
        listener: (context, state) {},
        builder: (context, state) {
          introCubit = IntroCubit.get(context);
          introList = introCubit!.introList;
          isLoading = introCubit!.isLoading;
          final pages = introList!.isEmpty
              ? []
              : [
                  FirstSplash(
                    videoUrl: introList![0].youtubeLink,
                    imgUrl: introList![0].image,
                    onFullScreenToggle: (bool) {
                      setState(() {
                        isFullScreen = bool;
                      });
                    },
                    isFullScreen: this.isFullScreen,
                  ),
                  secondSplash(
                      context, introList![1].image, introList![1].title),
                  thirdSplash(
                    context,
                    introList![2].image,
                    introList![2].title,
                  )
                ];

          return Scaffold(
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: isLoading == true
                      ? Center(child: CircularProgressIndicator())
                      : PageView.builder(
                          controller: controller,
                          onPageChanged: (int index) {
                            if (index == 3) {
                              (box.read(Constants.role.toString()) == "lecturer"
                                  ? Get.offAll(() => TeacherBottomNavBarScreen())
                                  : Get.offAll(() => BottomNavBarScreen()));
                            }
                          },
                          itemBuilder: (_, index) {
                            return pages[index % pages.length];
                          }),
                ),
             if(!isFullScreen)   Padding(
                  padding: EdgeInsets.only(bottom: 100.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SmoothPageIndicator(
                        controller: controller,
                        count: pages.length,
                        effect: WormEffect(
                          dotHeight: 12,
                          dotWidth: 12,
                          type: WormType.thin,
                          // strokeWidth: 5,
                        ),
                      ),
                      if(!isFullScreen)  SizedBox(
                        height: 15.h,
                      ),
                      if(!isFullScreen)   GestureDetector(
                        onTap: () {
                          (box.read(Constants.role.toString()) == "lecturer"
                              ? Get.offAll(() => TeacherBottomNavBarScreen())
                              : Get.offAll(() => BottomNavBarScreen()));
                        },
                        child: Container(
                          height: 52.w,
                          width: 52.w,
                          decoration: BoxDecoration(
                            color: const Color(0xffEAEAEA),
                            borderRadius: BorderRadius.circular(20.h),
                          ),
                          child: const RotatedBox(
                            quarterTurns: 3,
                            child: Icon(Icons.arrow_back_ios_rounded),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget secondSplash(BuildContext context, String image, String? title) {
    return Container(
        child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: double.infinity,
          child: Image.asset(
            "assets/images/splash2.png",
            fit: BoxFit.fill,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              image,
              height: 244.h,
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                title ?? "",
                style: TextStyle(fontSize: 19),
              ),
            ),
          ],
        ),
      ],
    ));
  }

  Widget thirdSplash(BuildContext context, String image, String? title) {
    return Container(
        child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: double.infinity,
          child: Image.asset(
            "assets/images/splash3.png",
            fit: BoxFit.fill,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              image,
              height: 244.h,
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                title ?? "",
                style: TextStyle(fontSize: 19),
              ),
            ),
            // Text(
            //   "العالم العربي",
            //   style: TextStyle(fontSize: 19),
            // ),
          ],
        ),
      ],
    ));
  }
}
