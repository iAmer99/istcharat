import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:istchrat/screens/course_details/course_details_screen.dart';
import 'package:istchrat/screens/online_course/models/online_model.dart';
import 'package:istchrat/shared_components/colors.dart';

import '../../course_details/online_details/online_course_details_screen.dart';

class OnlineCourseItem extends StatelessWidget {
  final onlinecourses? online_course_list;

  const OnlineCourseItem({Key? key, @required this.online_course_list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector( onTap: () {
      Get.to(() => OnlineCourseDetailsScreen(
        id: online_course_list!.id,
      ));
    },
      child: Container(
        margin: EdgeInsetsDirectional.all(5),
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
                              width: 8.w,
                            ),
                            Text(
                              "${online_course_list!.date.toString()}",
                              style:
                                  TextStyle(fontSize: 13.sp, color: Colors.grey),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Container(
                                height: 10.h,
                                width: 2,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              "${online_course_list!.time}",
                              style:
                                  TextStyle(fontSize: 13.sp, color: Colors.grey),
                            )
                          ],
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset("assets/icons/starbroken.svg"),
                ),
                Container(
                  height: 40.h,
                  width: 100.h,
                  decoration: BoxDecoration(
                      color: yelloCollor,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(25))),
                  child: Center(
                      child: Text(!online_course_list!.is_purchased!?
                    "buy_now".tr:"reserve".tr,
                    style: TextStyle(fontSize: 13.sp),
                  )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
