import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:istchrat/shared_components/colors.dart';

class QuestionAnswerConfirmationDetails extends StatelessWidget {
  QuestionAnswerConfirmationDetails({this.name,this.image,this.university,this.position,
    this.period,this.time,this.date}) ;
  String? name,image,position,university,date,time,period;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.h),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 15.h),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 99.h,
                  width: 76.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14.h),
                    child: image != null && image!.isNotEmpty ? Image.network(
                      image!,
                      fit: BoxFit.cover,
                    ) : Image.asset(
                      "assets/images/user.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$name",
                        style: TextStyle(color: Colors.black, fontSize: 15.w),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      if(position != null && position!.isNotEmpty) Text(
                        "$position",
                        style: TextStyle(color: grey, fontSize: 15.w),
                      ),
                      if(position != null && position!.isNotEmpty) SizedBox(
                        height: 5.h,
                      ),
                      if(university != null && university!.isNotEmpty)  Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/university.svg',
                            height: 16.h,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Expanded(
                            child: Text(
                              "$university",
                              style: TextStyle(color: grey, fontSize: 15.w),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            // Container(
            //   width: double.infinity,
            //   margin: EdgeInsets.symmetric(
            //     horizontal: 14.w,
            //   ),
            //   padding: EdgeInsets.symmetric(vertical: 10.h),
            //   decoration: BoxDecoration(
            //     color: const Color(0xffF5F6F8),
            //     borderRadius: BorderRadius.circular(10.h),
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       SvgPicture.asset(
            //         'assets/icons/clock.svg',
            //         color: Colors.black,
            //         height: 24.w,
            //       ),
            //       SizedBox(
            //         width: 5.w,
            //       ),
            //       Text(
            //         "$date - $time - $period",
            //         style: TextStyle(color: Colors.black, fontSize: 12.w),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}