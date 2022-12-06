import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:istchrat/shared_components/colors.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({
    Key? key,
    required this.question,
    required this.date,
    required this.onPressed,
  }) : super(key: key);
  final String question;
  final String date;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.h),
          border: Border.all(color: lightGrey)),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
            child: Row(
              // textDirection: TextDirection.rtl,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.h),
                    border: Border.all(
                      color: lightGrey,
                    ),
                  ),
                  padding: EdgeInsets.all(15.h),
                  child: SvgPicture.asset(
                    'assets/icons/question.svg',
                    height: 46.h,
                  ),
                ),
                SizedBox(
                  width: 30.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question,
                        style: TextStyle(
                          color: darkGrey,
                          fontSize: 14.w,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/calendar-bold.svg",
                            color: yelloCollor,
                            height: 11.6.w,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            date,
                            style: TextStyle(
                              color: blueGrey,
                              fontSize: 12.w,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              onPressed();
            },
            child: Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: yelloCollor,
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(20.h),
                    bottomEnd: Radius.circular(20.h),
                  ),
                ),
                child: Text(
                  "continue".tr,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.w,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
