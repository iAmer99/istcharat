import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../colors.dart';

class CustomAppBar {
  static PreferredSizeWidget appBar(BuildContext context,
      {required String text,
      List<Widget>? actions,
      bool search = false,
      bool backButton = true,
      Function(String)? onSearch}) {
    return AppBar(
      backgroundColor: const Color(0xffFAFAFA),
      toolbarHeight: 80.h,
      leadingWidth: 72.w,
      leading: Navigator.of(context).canPop() && backButton
          ? GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.w),
                    border: Border.all(
                      color: lightGrey,
                    )),
                margin: EdgeInsetsDirectional.only(
                    start: 20.w, top: 10.h, bottom: 10.h),
                padding: EdgeInsetsDirectional.only(start: 5.w),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
            )
          : null,
      actions: actions,
      title: search
          ? ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 60.h),
              child: TextField(
                onChanged: (value) {
                  if (onSearch != null) {
                    onSearch(value);
                  }
                },
                decoration: InputDecoration(
                  hintText: "search".tr,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.h),
                    borderSide: BorderSide(color: greyShap),
                  ),
                ),
              ),
            )
          : Text(
              text,
              style: const TextStyle(color: Colors.black),
            ),
      centerTitle: true,
      elevation: 0,
    );
  }
}
