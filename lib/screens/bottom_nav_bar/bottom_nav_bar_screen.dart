import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get_storage/get_storage.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/account_screen.dart';
import 'package:istchrat/screens/bottom_nav_bar/favourite_screen/favourite_screen.dart';
import 'package:istchrat/screens/bottom_nav_bar/my_library_screen/my_library_screen.dart';
import 'package:istchrat/screens/course_details/widgets/videolist/youtubplayer_wiget.dart';
import 'package:istchrat/screens/main/main_screen.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:istchrat/shared_components/constants/constants.dart';

class BottomNavBarScreen extends StatefulWidget {
  BottomNavBarScreen({Key? key, this.index = 0, this.openMyLibrary = false}) : super(key: key);
  final int index;
  final bool openMyLibrary;

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int currentIndex = 0;
  int libraryIndex = 0;


  List screens = [
    MainScreen(),
    FavouriteScreen(),
    MyLibraryScreen(),
    AccountScreen(),
  ];

  checkCurrentIndex(int index) {
    setState(() {
      currentIndex = index;
      libraryIndex = 0;
    });
  }

  @override
  void initState() {
    if(widget.openMyLibrary){
      currentIndex = 2;
      libraryIndex = widget.index;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) {
            checkCurrentIndex(index);
          },
          selectedItemColor: mainColor,
          items: [
            BottomNavigationBarItem(
              label: "explore".tr,
              icon: SvgPicture.asset('assets/icons/bottom_bar_explore.svg'),
              activeIcon: SvgPicture.asset('assets/icons/explore_colored.svg',
                  color: mainColor),
            ),
            BottomNavigationBarItem(
              label: "favourite".tr,
              icon: SvgPicture.asset('assets/icons/bottom_bar_star.svg'),
              activeIcon: SvgPicture.asset('assets/icons/star_colored.svg',
                  color: mainColor),
            ),
            BottomNavigationBarItem(
              label: "my_library".tr,
              icon: SvgPicture.asset('assets/icons/bottom_bar_library.svg'),
              activeIcon: SvgPicture.asset('assets/icons/library_colored.svg',
                  color: mainColor),
            ),
            BottomNavigationBarItem(
              label: "account".tr,
              icon: SvgPicture.asset('assets/icons/bottom_bar_user.svg'),
              activeIcon: SvgPicture.asset('assets/icons/user_colored.svg',
                  color: mainColor),
            ),
          ]),
      body: Stack(
        children: [
         if(currentIndex == 0) MainScreen(),
          if(currentIndex == 1) FavouriteScreen(),
          if(currentIndex == 2) MyLibraryScreen(index: libraryIndex,),
          if(currentIndex == 3) AccountScreen(),
        ],
      ),
    );
  }
}
