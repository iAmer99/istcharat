import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:istchrat/custom_widgets/custom_container.dart';
import 'package:istchrat/custom_widgets/custom_dialogs/nodata.dart';
import 'package:istchrat/custom_widgets/custom_offline_container.dart';
import 'package:istchrat/screens/course_details/course_details_screen.dart';
import 'package:istchrat/screens/course_details/online_details/online_course_details_screen.dart';
import 'package:istchrat/screens/main/cubit/main_cubit.dart';
import 'package:istchrat/screens/main/widgets/online_course_item.dart';
import 'package:istchrat/screens/online_course/cubit/online_state.dart';
import 'package:istchrat/screens/online_course/cubit/onlinecourse_cubit.dart';
import 'package:istchrat/screens/online_course/models/online_model.dart';
import 'package:istchrat/screens/recorded_course/cubit/recorded_course_cubit.dart';
import 'package:istchrat/screens/recorded_course/cubit/recorded_state.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../shared_components/widgets/custom_app_bar.dart';

class OnlineCourse extends StatefulWidget {
  final String? title;

  const OnlineCourse({Key? key, @required this.title}) : super(key: key);

  @override
  State<OnlineCourse> createState() => _OnlineCourseState();
}

class _OnlineCourseState extends State<OnlineCourse> {
  SnackBar? snackBar;
  late OnlineCourseCubit onlineCourseCubit;
  OnlineModel? data = new OnlineModel();
  bool isLoading = true;
  List<onlinecourses>? onlineList;
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
        create: (context) => OnlineCourseCubit()..getOnlineList(),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar.appBar(
            context,
            text: widget.title ?? "",
            search: showSearch,
            onSearch: (value){
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
          body: Container(
              color: Colors.white,
              child: BlocConsumer<OnlineCourseCubit, OnlineState>(
                  listener: (contetxt, state) {
                if (state is OnlineStateError) {
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
                onlineCourseCubit = OnlineCourseCubit.get(context);
                data = onlineCourseCubit.online_model;
                isLoading = onlineCourseCubit.isLoading;
                if (isLoading == false) {
                  if(keyword.isEmpty){
                    onlineList = data!.data!.onlineList!;
                  }else{
                   onlineList =  data!.data!.onlineList!.where((element) => element.title!.toLowerCase().contains(keyword.toLowerCase())).toList();
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
                          : (onlineList!.isEmpty
                              ? Center(
                                  child: NoData(
                                    img: "assets/icons/online-course.svg",
                                  ))
                              : ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: onlineList!.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.h, vertical: 8.h),
                                        child: GestureDetector(
                                            onTap: () {
                                              Get.to(
                                                  OnlineCourseDetailsScreen(
                                                id: onlineList?[index].id,
                                              ));
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.h,
                                                  vertical: 8.h),
                                              child: Container(
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
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10),
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
                                                              onlineList?[
                                                                      index]
                                                                  .image ?? "",
                                                              fit:
                                                                  BoxFit.fill,
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
                                                                  "${onlineList![index].title ?? ""}",
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      fontSize: 12
                                                                          .sp,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                SizedBox(
                                                                  height: 5.h,
                                                                ),
                                                                Expanded(
                                                                  child: Row(
                                                                    children: [
                                                                      SvgPicture.asset(
                                                                          "assets/icons/calendar.svg"),
                                                                      SizedBox(
                                                                        width:
                                                                            4.w,
                                                                      ),
                                                                      Text(
                                                                        "${onlineList?[index].date ?? ""}",
                                                                        style: TextStyle(
                                                                            fontSize: 13.sp,
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
                                                                    "${onlineList?[index].price ?? ""}" +
                                                                        " " +
                                                                        "${onlineList?[index].currency ?? ""}",
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
                                                    Flexible(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: SvgPicture
                                                                .asset(
                                                                    "assets/icons/starbroken.svg"),
                                                          ),
                                                          Container(
                                                            height: 40.h,
                                                            width: 100.h,
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    yelloCollor,
                                                                borderRadius:
                                                                    BorderRadius.only(
                                                                        topLeft:
                                                                            Radius.circular(25))),
                                                            child: Center(
                                                                child: Text(
                                                              !onlineList![
                                                                          index]
                                                                      .is_purchased!
                                                                  ? "reserve"
                                                                      .tr
                                                                  : "watch"
                                                                      .tr,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13.sp),
                                                            )),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )));
                                  }))
                    ],
                  ),
                );
              })),
        ));
  }
}
