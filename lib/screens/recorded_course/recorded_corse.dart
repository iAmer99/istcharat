import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:istchrat/screens/course_details/course_details_screen.dart';
import 'package:istchrat/screens/main/cubit/main_cubit.dart';
import 'package:istchrat/screens/recorded_course/cubit/recorded_course_cubit.dart';
import 'package:istchrat/screens/recorded_course/cubit/recorded_state.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../custom_widgets/custom_dialogs/nodata.dart';
import '../../shared_components/widgets/custom_app_bar.dart';
import 'models/recorded_course_model.dart';

class RecordedCourse extends StatefulWidget {
  final String? title;

  const RecordedCourse({Key? key, @required this.title}) : super(key: key);

  @override
  State<RecordedCourse> createState() => _RecordedCourseState();
}

class _RecordedCourseState extends State<RecordedCourse> {
  SnackBar? snackBar;
  late RecordedCourseCubit recordedCourseCubit;
  Recorded_course_model? data = new Recorded_course_model();
  bool isLoading = true;
  List<recordedCourses>? recordedList;
  bool showSearch = false;
  String keyword = "";

  @override
  void customSnackBar(String content, Color color, Duration duration,
      SnackBarAction snackBarAction) {
    snackBar = SnackBar(
      content: Text(content),
      backgroundColor: color,
      duration: duration,
      action: snackBarAction,
    );
    // Timer(Duration(seconds: 1), () {
    //   // _loginController.reset();
    //   ScaffoldMessenger.of(context).showSnackBar(snackBar!);
    // });
    scaffoldKey.currentState!.showSnackBar(snackBar!);
  }

  final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => RecordedCourseCubit()..getRecordedList(),
        child: Container(
          color: Colors.white,
          child: Scaffold(
            appBar: CustomAppBar.appBar(
              context,
              text: widget.title ?? "",
              search: showSearch,
              onSearch: (value) {
                setState(() {
                  keyword = value;
                });
              },
              actions: [
                Padding(
                  padding: EdgeInsetsDirectional.only(end: 10.w),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        showSearch = !showSearch;
                      });
                    },
                    icon: SvgPicture.asset(
                      "assets/icons/search.svg",
                      height: 30.h,
                      width: 30.w,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.white,
            body: Container(
                color: Colors.white,
                child: BlocConsumer<RecordedCourseCubit, RecordedState>(
                    listener: (context, state) {
                  if (state is RecordedStateError) {
                    customSnackBar(
                        "network_error".tr,
                        Colors.red,
                        Duration(days: 1),
                        SnackBarAction(
                            label: "",
                            textColor: Colors.white,
                            onPressed: () {
                              scaffoldKey.currentState!.hideCurrentSnackBar();
                              //ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            }));
                  }
                }, builder: (context, state) {
                  recordedCourseCubit = RecordedCourseCubit.get(context);
                  data = recordedCourseCubit.recorded_model;
                  isLoading = recordedCourseCubit.isLoading;
                  if (isLoading == false) {
                    if (keyword.isEmpty) {
                      recordedList = data!.data!.recordedList!;
                    } else {
                      recordedList = data!.data!.recordedList!
                          .where((element) => element.title!.toLowerCase().contains(keyword.toLowerCase()))
                          .toList();
                    }
                  }
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        isLoading == true
                            ? Center(child: CircularProgressIndicator())
                            : (recordedList!.isEmpty
                                ? Center(
                                    child: NoData(
                                      img: "assets/icons/recordedcourse.svg",
                                    ),
                                  )
                                : ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: recordedList!.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.h, vertical: 8.h),
                                        child: GestureDetector(
                                            onTap: () {
                                              Get.to(() => CourseDetailsScreen(
                                                  id: recordedList![index]
                                                      .id!));
                                            },
                                            child: Container(
                                                margin:
                                                    EdgeInsetsDirectional.all(
                                                        5),
                                                clipBehavior: Clip.antiAlias,
                                                height: 110.h,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                    border: Border.all(
                                                        color: lightGrey)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10.w,
                                                                  vertical:
                                                                      15.h),
                                                          child: Container(
                                                            height: 73.h,
                                                            width: 73.h,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            child:
                                                                Image.network(
                                                              recordedList?[
                                                                      index]
                                                                  .image ?? "",
                                                              fit: BoxFit.fill,
                                                                  errorBuilder: (context, _, v)=> Image.asset(
                                                                    "assets/images/no_image.jpg",
                                                                    fit: BoxFit.cover,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .4,
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        15.h),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "${recordedList?[index].title ?? ""}",
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12.sp,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                SizedBox(
                                                                  height: 5.h,
                                                                ),
                                                                Visibility(
                                                                  visible:
                                                                      true,
                                                                  child: Row(
                                                                    children: [
                                                                      SvgPicture
                                                                          .asset(
                                                                              "assets/icons/calendar.svg"),
                                                                      SizedBox(
                                                                        width:
                                                                            3.w,
                                                                      ),
                                                                      Text(
                                                                        "${recordedList![index].date.toString()}",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                13.sp,
                                                                            color: Colors.grey),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 5.h,
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    "${recordedList![index].price}" +
                                                                        " " +
                                                                        "${recordedList![index].currency}",
                                                                    style: TextStyle(
                                                                        fontSize: 15
                                                                            .sp,
                                                                        color:
                                                                            yelloCollor,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: SvgPicture.asset(
                                                              "assets/icons/starbroken.svg"),
                                                        ),
                                                        Container(
                                                          height: 40.h,
                                                          width: 100.h,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  yelloCollor,
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          25))),
                                                          child: Center(
                                                              child: Text(
                                                            recordedList![index]
                                                                    .is_purchased!
                                                                ? "watch".tr
                                                                : "buy_now".tr,
                                                            style: TextStyle(
                                                                fontSize:
                                                                    13.sp),
                                                          )),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ))),
                                      );
                                    }))
                      ],
                    ),
                  );
                })),
          ),
        ));
  }
}
