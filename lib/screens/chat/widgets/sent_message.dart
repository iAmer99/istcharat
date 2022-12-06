import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:istchrat/shared_components/colors.dart';

import '../../../main.dart';
import '../../../shared_components/constants/constants.dart';

class SentMessage extends StatelessWidget {
  const SentMessage({Key? key, required this.message, required this.time, required this.image}) : super(key: key);
  final String message;
  final String time;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18.5.w,
            backgroundImage: NetworkImage(image),
          ),
          SizedBox(
            width: 14.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.only(
                        topEnd: Radius.circular(20.h),
                        bottomEnd: Radius.circular(20.h),
                        bottomStart: Radius.circular(20.h),
                      ).resolve(box.read(Constants.lang.toString()) == "en" ? TextDirection.ltr : TextDirection.rtl),
                      color: mainColor,
                      border: Border.all(color: lightGrey)),
                  padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
                  alignment: AlignmentDirectional.centerStart,
                  width: double.infinity,
                  child: Text(
                    message,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.w,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 14.h,
                    fontWeight: FontWeight.w500,
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
