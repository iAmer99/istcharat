import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:istchrat/shared_components/colors.dart';

import '../../../../../../main.dart';
import '../../../../../../shared_components/constants/constants.dart';

class SentQuestion extends StatelessWidget {
  const SentQuestion({Key? key, required this.question, required this.time, required this.image}) : super(key: key);
  final String question;
  final String time;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15.h, bottom: 15.h),
      child: Row(
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
                      color: mainColor,
                      border: Border.all(color: lightGrey)),
                  padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
                  width: double.infinity,
                  alignment: AlignmentDirectional.centerEnd,
                  child: Text(
                    question,
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
                    color: lightGrey,
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
            backgroundImage: getImage(),
          ),
        ],
      ),
    );
  }

  ImageProvider getImage(){
    if(image.isEmpty){
      return const AssetImage("assets/images/user.png");
    }else{
      return NetworkImage(image);
    }
  }
}
