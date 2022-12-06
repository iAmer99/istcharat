import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:istchrat/screens/bottom_nav_bar/bottom_nav_bar_screen.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:istchrat/shared_components/widgets/rounded_yellow_button.dart';

class SuccessDialogContent extends StatelessWidget {
   SuccessDialogContent({Key? key,required this.message}) : super(key: key);
   final String message ;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/images/done.png", height: 60.h,),
        SizedBox(height: 5.h,),
        Text(
          "Thank you",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10.h,),
        Text(
          "$message",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10.h,),
        Text(
          "",
          style: TextStyle(
            color: mainColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 15.h,),
        RoundedYellowButton(text: "Done", onTap: (){
          Navigator.pop(context);
        }),
        SizedBox(height: 15.h,),
        GestureDetector(
          onTap: (){
            Get.to(()=>BottomNavBarScreen());
          },
          child: Text(
            "Back to Main",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
