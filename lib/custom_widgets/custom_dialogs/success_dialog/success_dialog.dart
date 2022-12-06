import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../shared_components/colors.dart';
import '../../../shared_components/widgets/rounded_yellow_button.dart';



 successDialog(
     {BuildContext? context,
    String? message,
    String? buttonTitle,
    Function()? onTap}){
  showDialog(context: context!, builder: (context){
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        ),
        height: 300.sp,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                visible: false,
                child: Text(
                  "istcharat".tr,
                  style: TextStyle(fontSize: 21.sp,fontWeight: FontWeight.bold,color: darkGrey ),
                ),
              ),
              Center(
                child: Text(
                  message!,
                  style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w600 ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundedYellowButton(text: buttonTitle!, onTap : onTap!),
                  SizedBox(height: 20.w,),
                  GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Text("cancel".tr)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  });
}