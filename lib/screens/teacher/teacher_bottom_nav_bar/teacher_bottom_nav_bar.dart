import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/account_screen.dart';
import 'package:istchrat/screens/teacher/logs/logs_screen.dart';
import '../teacher_main/view/teacher_main.dart';
import 'package:istchrat/screens/teacher/teacher_waiting/teacher_waiting_screen.dart';
import 'package:istchrat/shared_components/colors.dart';

class TeacherBottomNavBarScreen extends StatefulWidget {
  final int index;
  final bool openWaiting;

  const TeacherBottomNavBarScreen({super.key, this.index = 0, this.openWaiting = false});

  @override
  State<TeacherBottomNavBarScreen> createState() => _TeacherBottomNavBarScreenState();
}

class _TeacherBottomNavBarScreenState extends State<TeacherBottomNavBarScreen> {
  int currentIndex = 0;
  int waitingIndex = 0;

  List screens = [
    TeacherMain(),
    LogsScreen(),
    TeacherWaitingScreen(comeFromMain: false,categoryKey: "",title: "waiting".tr,),
    AccountScreen(),
  ];

  checkCurrentIndex(int index){
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    if(widget.openWaiting){
      currentIndex = 2;
      waitingIndex = widget.index;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index){
            checkCurrentIndex(index);
          },
          selectedItemColor: mainColor,
          items: [
            BottomNavigationBarItem(
              label: "statistics_nav_bar".tr,
              icon: SvgPicture.asset('assets/icons/statistics_icon.svg'),
              activeIcon: SvgPicture.asset('assets/icons/statistics_colored.svg'
                  ,color: mainColor),
            ),
            BottomNavigationBarItem(
              label: "logs".tr,
              icon: SvgPicture.asset('assets/icons/history_icon.svg'),
              activeIcon: SvgPicture.asset('assets/icons/history_colored.svg',color: mainColor),
            ),
            BottomNavigationBarItem(
              label: "waiting".tr,
              icon: SvgPicture.asset('assets/icons/waiting_icon.svg'),
              activeIcon: SvgPicture.asset('assets/icons/waiting_colored.svg',color: mainColor),
            ),
            BottomNavigationBarItem(
              label: "account".tr,
              icon: SvgPicture.asset('assets/icons/bottom_bar_user.svg'),
              activeIcon: SvgPicture.asset('assets/icons/user_colored.svg',
                  color: mainColor
              ),
            ),
          ]),
      body: Stack(
        children: [
          if(currentIndex == 0)  TeacherMain(),
          if(currentIndex == 1) LogsScreen(),
          if(currentIndex == 2) TeacherWaitingScreen(comeFromMain: false,categoryKey: "",title: "waiting".tr,index: waitingIndex,),
          if(currentIndex == 3) AccountScreen(),
        ],
      ),
    );
  }
}
