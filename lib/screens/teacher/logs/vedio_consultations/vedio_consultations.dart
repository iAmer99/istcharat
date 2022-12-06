import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:istchrat/screens/teacher/logs/vedio_consultations/vedio_consultation_item.dart';
import 'package:istchrat/screens/teacher/teacher_waiting/teacher_waiting_item.dart';
import 'package:istchrat/shared_components/colors.dart';

class VedioConsultations extends StatelessWidget {
  const VedioConsultations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: mintGreen,
        toolbarHeight: 66.h,
        leadingWidth: 82.w,
        leading: GestureDetector(
          child: Container(
            width: 40.w, height: 30.h,
            margin: EdgeInsetsDirectional.only(
                start: 15.w, end: 10.w, top: 10.h, bottom: 10.h),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: lightGrey)),
            // padding: EdgeInsets.all(5.h),
            child: Icon(
              Icons.arrow_back_ios_outlined,
              size: 24.h,
              color: darkGrey,
            ),
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsetsDirectional.only(start: 10.w, end: 10.w),
            child: Row(
              children: [
                SizedBox(
                  width: 6.w,
                ),
                SvgPicture.asset(
                  "assets/icons/search.svg",
                  width: 30.w,
                  height: 30.h,
                ),
                SizedBox(
                  width: 10.w,
                ),
                SvgPicture.asset(
                  "assets/icons/filter.svg",
                  width: 30.w,
                  height: 30.h,
                ),
              ],
            ),
          )
        ],
        title: Text(
          "Vedio Consultations",
          style: TextStyle(color: Colors.black, fontSize: 15.sp),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
          child: Container(
        margin: EdgeInsetsDirectional.only(
            start: 10.w, end: 10.w, top: 20.h, bottom: 10.h),
        child: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) {
              return VedioConsultationItem();
            }),
      )),
    ));
  }
}
