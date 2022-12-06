import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:istchrat/screens/teacher/logs/vedio_consultations/vedio_consultation_details.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VedioConsultationItem extends StatelessWidget {
  final bool? visible;
  const VedioConsultationItem({Key? key, @required this.visible = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(VedioConsultationDetails());
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 8.h),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 12.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: lightGrey)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/document.svg",
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "Video Call",
                            style:
                                TextStyle(fontSize: 12.sp, color: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/user.svg",
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              "Ahmed Mohamed",
                              style: TextStyle(
                                  fontSize: 12.sp, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/clock.svg",
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "5 o`clock",
                            style:
                                TextStyle(fontSize: 12.sp, color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/status.svg",
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "Waitting",
                            style:
                                TextStyle(fontSize: 12.sp, color: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/dollar.svg",
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              "20 Dinar",
                              style: TextStyle(
                                  fontSize: 12.sp, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/mobil.svg",
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "010253141616161616161  ",
                            style:
                                TextStyle(fontSize: 12.sp, color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Visibility(
                visible: visible!,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.h, horizontal: 30.w),
                      decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(25)),
                      child: Text(
                        "Accept",
                        style: TextStyle(fontSize: 12.sp, color: Colors.white),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.h, horizontal: 30.w),
                      decoration: BoxDecoration(
                          color: yelloCollor,
                          borderRadius: BorderRadius.circular(25)),
                      child: Text(
                        "Delay",
                        style: TextStyle(fontSize: 12.sp, color: darkGrey),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 30.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: redColor)),
                      child: Text(
                        "Refuse",
                        style: TextStyle(fontSize: 12.sp, color: redColor),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
