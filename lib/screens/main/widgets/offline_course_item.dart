import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:istchrat/screens/course_details/course_details_screen.dart';
import 'package:istchrat/screens/main/cubit/main_cubit.dart';
import 'package:istchrat/screens/main/models/home_model.dart';
import 'package:istchrat/shared_components/colors.dart';

class OfflineCourseItem extends StatelessWidget {
  final OfflineCourses? offline_course_list;
  final Function(String) addToFav;
  final Function(String) removeFromFav;
  final MainCubit? mainCubit;

  const OfflineCourseItem(
      {Key? key,
      @required this.offline_course_list,
      required this.addToFav,
      required this.removeFromFav, this.mainCubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 8.h),
      child: GestureDetector(
          onTap: () {
            Get.to(() => CourseDetailsScreen(
                  id: offline_course_list!.id,
              mainCubit: mainCubit,
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
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 15.h),
                        child: Container(
                          height: 73.h,
                          width: 73.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey,
                          ),
                          child: Image.network(
                            offline_course_list!.image!,
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
                                "${offline_course_list!.title}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 12.sp, color: Colors.black),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Visibility(
                                visible: true,
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                        "assets/icons/calendar.svg"),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    Text(
                                      "${offline_course_list!.date.toString()}",
                                      style: TextStyle(
                                          fontSize: 13.sp, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Expanded(
                                child: Text(
                                  "${offline_course_list!.price}" +
                                      " " +
                                      "${offline_course_list!.currency}",
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
                        child: GestureDetector(
                          onTap: () {
                            if (!offline_course_list!.isFavorite!) {
                              addToFav(offline_course_list!.id.toString());
                            } else {
                              removeFromFav(offline_course_list!.id.toString());
                            }
                          },
                          child: offline_course_list!.isFavorite!
                              ? SvgPicture.asset(
                                  'assets/icons/star_colored.svg',
                                  color: yelloCollor)
                              : SvgPicture.asset("assets/icons/starbroken.svg"),
                        ),
                      ),
                      Container(
                        height: 40.h,
                        width: 100.h,
                        decoration: BoxDecoration(
                            color: yelloCollor,
                            borderRadius: BorderRadiusDirectional.only(
                                topStart: Radius.circular(25))),
                        child: Center(
                            child: Text(offline_course_list!.isPurchased==true?
                          "watch".tr: "buy_now".tr,
                          style: TextStyle(fontSize: 13.sp),
                        )),
                      )
                    ],
                  )
                ],
              ))),
    );
  }
}
