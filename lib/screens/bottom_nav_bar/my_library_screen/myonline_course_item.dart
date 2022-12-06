import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:istchrat/screens/course_details/course_details_screen.dart';
import 'package:istchrat/screens/online_course/models/online_model.dart';
import 'package:istchrat/shared_components/colors.dart';

class MyOnlineCourseItem extends StatelessWidget {
  final onlinecourses? online_course_list;

  const MyOnlineCourseItem({Key? key, this.online_course_list})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.all(10),
      clipBehavior: Clip.antiAlias,
      height: 110.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: lightGrey)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                child: Container(
                  height: 73.h,
                  width: 73.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey,
                  ),
                  child: Image.network(
                    online_course_list!.image!,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .4,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${online_course_list!.title}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12.sp, color: Colors.black),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset("assets/icons/calendar.svg"),
                          SizedBox(
                            width: 3.w,
                          ),
                          Flexible(
                            child: Text(
                              "${online_course_list!.date.toString()}",
                              style:
                                  TextStyle(fontSize: 13.sp, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Expanded(
                        child: Text(
                          "${online_course_list!.price}" + " " + "${online_course_list!.currency}",
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: yelloCollor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
           online_course_list!.is_favorite! ? Padding(
             padding: const EdgeInsets.all(8.0),
             child: SvgPicture.asset("assets/icons/star_colored.svg", color: yelloCollor,),
           ) : Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset("assets/icons/starbroken.svg"),
              ),
              Container(
                height: 40.h,
                width: 100.h,
                decoration: BoxDecoration(
                    color: yelloCollor,
                    borderRadius:
                    BorderRadiusDirectional.only(
                        topStart: Radius.circular(25))),
                child: Center(
                    child: Text(
                  "watch".tr,
                  style: TextStyle(fontSize: 13.sp),
                )),
              )
            ],
          )
        ],
      ),
    );
  }
}
