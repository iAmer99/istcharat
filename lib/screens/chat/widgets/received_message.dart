import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:istchrat/main.dart';
import 'package:istchrat/shared_components/colors.dart';

import '../../../shared_components/constants/constants.dart';

class ReceivedMessage extends StatelessWidget {
  const ReceivedMessage({Key? key, required this.message, required this.time, required this.image}) : super(key: key);
  final String message;
  final String time;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(20.h),
                      bottomEnd: Radius.circular(20.h),
                      bottomStart: Radius.circular(20.h),
                    ).resolve(box.read(Constants.lang.toString()) == "en" ? TextDirection.ltr : TextDirection.rtl),
                    color: Colors.white,
                    border: Border.all(color: lightGrey)),
                padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
                width: double.infinity,
                alignment: AlignmentDirectional.centerEnd,
                child: Text(
                  message,
                  style: TextStyle(
                    color: Colors.black,
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
        ),
        SizedBox(
          width: 14.w,
        ),
        CircleAvatar(
          radius: 18.5.w,
          backgroundImage: NetworkImage(image),
        ),
      ],
    );
  }
}
