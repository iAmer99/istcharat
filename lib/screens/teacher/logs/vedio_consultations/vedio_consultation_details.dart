import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:istchrat/custom_widgets/custom_text_field.dart';
import 'package:istchrat/screens/teacher/logs/vedio_consultations/vedio_consultation_item.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'attachment_item.dart';
import 'my_textfield.dart';

class VedioConsultationDetails extends StatefulWidget {
  const VedioConsultationDetails({Key? key}) : super(key: key);

  @override
  State<VedioConsultationDetails> createState() =>
      _VedioConsultationDetailsState();
}

class _VedioConsultationDetailsState extends State<VedioConsultationDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: mintGreen,
        toolbarHeight: 70.h,
        leadingWidth: 70.w,
        leading: GestureDetector(
          child: Container(
            width: 50.w, height: 50.h,
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
        centerTitle: true,
        title: Text(
          "Details",
          style: TextStyle(color: Colors.black, fontSize: 15.sp),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
          ),
          VedioConsultationItem(
            visible: false,
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            margin: EdgeInsetsDirectional.only(start: 15.w, end: 15.w),
            child: Text(
              "Notes",
              style: TextStyle(color: mainColor, fontSize: 15.sp),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
              //height: 100.h,
              padding: EdgeInsetsDirectional.all(8),
              margin: EdgeInsetsDirectional.only(
                  start: 15.w, end: 15.w, bottom: 10.h),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: lightGrey)),
              child: MyTextField()),
          SizedBox(
            height: 20.h,
          ),
          Container(
            margin: EdgeInsetsDirectional.only(start: 15.w, end: 15.w),
            child: Text(
              "Attachments",
              style: TextStyle(color: mainColor, fontSize: 15.sp),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          ListView(
            children: [Attachment_item(), Attachment_item()],
          )
        ],
      ),
    ));
  }
}
