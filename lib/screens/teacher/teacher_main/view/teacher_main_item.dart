import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'main_content_teacher.dart';
import 'package:get/get.dart';
import 'package:istchrat/screens/teacher/teacher_main/models/MainTeacherModel.dart';


class TeacherMainItem extends StatelessWidget {

   final Data? teacherdata;
  const TeacherMainItem({Key? key,@required this.teacherdata})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1.0, color: lightGrey),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      margin: EdgeInsetsDirectional.only(
          top: 8.h, bottom: 5.h, start: 10.w, end: 10.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          main_content_teacher(
            icon: "${teacherdata!.icon}",
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${teacherdata!.type}"
                  ,
                  style: TextStyle(fontSize: 12.sp, color: Colors.black),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  margin: EdgeInsetsDirectional.only(start: 5.w, end: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${teacherdata!.total}",
                            style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "total".tr,
                            style:
                                TextStyle(fontSize: 12.sp, color: yelloCollor),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${teacherdata!.currentMonth}",
                            style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            "month".tr,
                            style:
                                TextStyle(fontSize: 12.sp, color: yelloCollor),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${teacherdata!.currentDay}",
                            style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "day".tr,
                            style:
                                TextStyle(fontSize: 12.sp, color: yelloCollor),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
