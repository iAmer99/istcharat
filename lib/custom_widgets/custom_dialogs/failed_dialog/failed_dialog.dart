import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../shared_components/colors.dart';
import '../../../shared_components/widgets/rounded_yellow_button.dart';

failedDialog({
  BuildContext? context,
  String? message,
  Function? onCancel,
}) {
  showDialog(
      context: context!,
      builder: (context) {
        return Dialog(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            height: 300.sp,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/error.png", height: 80.h,),
                  SizedBox(height: 30.h,),
                  Text(
                    message!,
                    style: TextStyle(
                        fontSize: 18.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 30.h,),
                  RoundedYellowButton(
                      text: "ok".tr,
                      onTap: () {
                        Navigator.pop(context);
                        if(onCancel != null){
                          onCancel();
                        }
                      }),
                ],
              ),
            ),
          ),
        );
      });
}
