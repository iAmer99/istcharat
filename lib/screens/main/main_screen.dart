import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:istchrat/main.dart';
import 'package:istchrat/screens/books_screens/books_screen.dart';
import 'package:istchrat/screens/consultation_screen/audio_consultation/audio_consultation_screen.dart';
import 'package:istchrat/screens/consultation_screen/chat_consultation/chat_consultation_screen.dart';
import 'package:istchrat/screens/consultation_screen/consultation_screen.dart';
import 'package:istchrat/screens/course_details/online_details/online_course_details_screen.dart';
import 'package:istchrat/screens/login/login_screen.dart';
import 'package:istchrat/screens/main/cubit/main_cubit.dart';
import 'package:istchrat/screens/main/cubit/main_state.dart';
import 'package:istchrat/screens/main/models/home_model.dart';
import 'package:istchrat/screens/main/widgets/booksItem.dart';
import 'package:istchrat/screens/main/widgets/home_header.dart';
import 'package:istchrat/screens/main/widgets/main_content.dart';
import 'package:istchrat/screens/main/widgets/offline_course_item.dart';
import 'package:istchrat/screens/main/widgets/image_slider.dart';
import 'package:istchrat/screens/notifications/binding/notifications_binding.dart';
import 'package:istchrat/screens/notifications/notifications_screen.dart';
import 'package:istchrat/screens/online_course/online_corse.dart';
import 'package:istchrat/screens/question_and_answer/question_and_answer_screen.dart';
import 'package:istchrat/screens/recorded_course/recorded_corse.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:get/get.dart';
import 'package:istchrat/shared_components/constants/constants.dart';

class MainScreen extends StatefulWidget {
  final Function? onPressed;

  const MainScreen({Key? key, @required this.onPressed}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  SnackBar? snackBar;
  late MainCubit mainCubit;
  HomeModel? data = new HomeModel();
  bool isLoading = true;
  List<Sliders>? sliders;
  List<OnlineCourses>? online_course_list;
  List<OfflineCourses>? offlineCourses_list;
  List<BooksAuthors>? books_list;

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
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: BlocProvider(
        create: (context) => MainCubit()
          ..getHomeData()
          ..setDeviceToken(),
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: Container(
                //width: 200.w,
                margin: EdgeInsetsDirectional.only(
                    top: 5.h, start: 20.w, end: 15.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (box.read(Constants.isLogged.toString()) ?? false) {
                          Get.to(() => const NotificationsScreen(),
                              binding: NotificationsBinding());
                        } else {
                          Get.to(() => LoginScreen(comeFromHome: true));
                        }
                      },
                      child: SvgPicture.asset(
                        "assets/icons/notification.svg",
                        width: 30.w,
                        height: 30.h,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Visibility(
                      visible: false,
                      child: SvgPicture.asset(
                        "assets/icons/search.svg",
                        width: 30.w,
                        height: 30.h,
                      ),
                    ),
                  ],
                ),
              ),
              leadingWidth: 150.w,
            ),
            body: BlocConsumer<MainCubit, MainState>(
              listener: (context, state) {
                if (state is MainError) {
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
                } else if (state is MainLoading) {
                  // mainCubit.getHomeData();
                }
              },
              builder: (context, state) {
                mainCubit = MainCubit.get(context);
                data = mainCubit.homeData;
                isLoading = mainCubit.isLoading;
                if (isLoading == false) {
                  online_course_list = data!.data!.onlineCourses!;
                  offlineCourses_list = data!.data!.offlineCourses!;
                  books_list = data!.data!.booksAuthors!;
                  sliders = data!.data!.sliders!;
                }
                print(isLoading);
                return Scaffold(
                  body: isLoading == true
                      ? Container(
                          child: Center(child: CircularProgressIndicator()))
                      : SingleChildScrollView(
                          child: Container(
                            margin: EdgeInsetsDirectional.only(
                                start: 5.w, end: 5.w),
                            color: Colors.white,
                            // height: MediaQuery.of(context).size.height,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              // mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 5.h,
                                ),
                                HomeHeader(),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Container(
                                  margin: EdgeInsetsDirectional.only(
                                      start: 10.w, end: 10.w),
                                  child: Text(
                                    "what_you_need".tr,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: darkBlue,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Column(
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      //crossAxisAlignment: CrossAxisAlignment.s,
                                      children: [
                                        if (data!.data!.consultations!
                                            .firstWhere((element) =>
                                                element.key ==
                                                "video_consultations")
                                            .value!)
                                          MainContent(
                                            icon: "assets/icons/video.svg",
                                            title: "video_consultation".tr,
                                            txtColor: Colors.black,
                                            bgColor: Colors.white,
                                            onPresses: () {
                                              Get.to(ConsultationScreen());
                                            },
                                          ),
                                        if (data!.data!.consultations!
                                            .firstWhere((element) =>
                                                element.key ==
                                                "voice_consultations")
                                            .value!)
                                          MainContent(
                                            icon:
                                                "assets/icons/audio_consultation.svg",
                                            title: "audio_consultation".tr,
                                            txtColor: Colors.black,
                                            bgColor: Colors.white,
                                            onPresses: () {
                                              Get.to(AudioConsultationScreen());
                                            },
                                          ),
                                        if (data!.data!.consultations!
                                            .firstWhere((element) =>
                                                element.key ==
                                                "chat_consultations")
                                            .value!)
                                          MainContent(
                                            icon: "assets/icons/chat.svg",
                                            title: "text_conversation".tr,
                                            txtColor: Colors.black,
                                            bgColor: Colors.white,
                                            onPresses: () {
                                              Get.to(ChatConsultationScreen(
                                                title: "text_conversation".tr,
                                                consultationType:
                                                    "chatConsultations",
                                              ));
                                            },
                                          )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      //crossAxisAlignment: CrossAxisAlignment.s,
                                      children: [
                                        if (data!.data!.consultations!
                                            .firstWhere((element) =>
                                        element.key == "faqs")
                                            .value!)
                                          MainContent(
                                            icon: "assets/icons/question.svg",
                                            title: "question_and_answer".tr,
                                            txtColor: Colors.black,
                                            bgColor: Colors.white,
                                            onPresses: () {
                                              Get.to(QuestionAndAnswerScreen(
                                                consultationType: "faqs",
                                                title: "question_and_answer".tr,
                                              ));
                                            },
                                          ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        if (data!.data!.consultations!
                                            .firstWhere((element) =>
                                        element.key ==
                                            "appointment_consultations")
                                            .value!)
                                          MainContent(
                                            icon: "assets/icons/clinic.svg",
                                            title: "book_place".tr,
                                            txtColor: Colors.black,
                                            bgColor: Colors.white,
                                            onPresses: () {
                                              Get.to(ChatConsultationScreen(
                                                title: "book_place".tr,
                                                consultationType:
                                                "appointmentConsultations",
                                              ));
                                            },
                                          ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        if (data!.data!.consultations!
                                            .firstWhere((element) =>
                                        element.key ==
                                            "emergency_consultations")
                                            .value!)
                                          MainContent(
                                            icon:
                                            "assets/icons/emergency_consultation.svg",
                                            title: "emergency_consultation".tr,
                                            txtColor: Colors.black,
                                            bgColor: Colors.white,
                                            onPresses: () {
                                              Get.to(QuestionAndAnswerScreen(
                                                consultationType:
                                                "emergencyConsultations",
                                                title:
                                                "emergency_consultation".tr,
                                              ));
                                            },
                                          ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      //crossAxisAlignment: CrossAxisAlignment.s,
                                      children: [
                                        MainContent(
                                          icon: "assets/icons/books.svg",
                                          title: "books_and_writings".tr,
                                          txtColor: Colors.black,
                                          bgColor: Colors.white,
                                          onPresses: () {
                                            Get.to(BooksScreen(
                                              title: "books_and_writings".tr,
                                            ));
                                          },
                                        ),
                                        MainContent(
                                          icon:
                                          "assets/icons/online-course.svg",
                                          title: "online_courses".tr,
                                          txtColor: Colors.black,
                                          bgColor: Colors.white,
                                          onPresses: () {
                                            Get.to(OnlineCourse(
                                              title: "online_courses".tr,
                                            ));
                                          },
                                        ),
                                        MainContent(
                                          icon:
                                          "assets/icons/recordedcourse.svg",
                                          title: "recorded_courses".tr,
                                          txtColor: Colors.black,
                                          bgColor: Colors.white,
                                          onPresses: () {
                                            Get.to(RecordedCourse(
                                                title: "recorded_courses".tr));
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                if (data?.data?.sliders != null &&
                                    data!.data!.sliders!.isNotEmpty)
                                  ImageSlider(
                                    sliders: data?.data?.sliders,
                                  ),
                                Container(
                                  margin: EdgeInsetsDirectional.only(
                                      top: 20.h, start: 10.w, end: 10.w),
                                  child: Text(
                                    'online_courses'.tr,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: darkBlue,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Container(
                                    height: 150.h,
                                    margin: EdgeInsetsDirectional.only(
                                        start: 5.w, end: 5.w),
                                    child: online_course_list!.length == 0
                                        ? Text("nodata".tr)
                                        : ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                online_course_list!.length,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  Get.to(
                                                      OnlineCourseDetailsScreen(
                                                    id: online_course_list![
                                                            index]
                                                        .id,
                                                    mainCubit: mainCubit,
                                                  ));
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
                                                        CrossAxisAlignment
                                                            .start,
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
                                                                online_course_list![
                                                                        index]
                                                                    .image!,
                                                                fit:
                                                                    BoxFit.fill,
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
                                                                    "${online_course_list![index].title}",
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
                                                                  Row(
                                                                    children: [
                                                                      SvgPicture
                                                                          .asset(
                                                                              "assets/icons/calendar.svg"),
                                                                      SizedBox(
                                                                        width:
                                                                            3.w,
                                                                      ),
                                                                      Flexible(
                                                                        child:
                                                                            Text(
                                                                          "${online_course_list![index].date.toString()}",
                                                                          style: TextStyle(
                                                                              fontSize: 13.sp,
                                                                              color: Colors.grey),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height: 5.h,
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      "${online_course_list![index].price}" +
                                                                          " " +
                                                                          "${online_course_list![index].currency}",
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
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                if (!online_course_list![
                                                                        index]
                                                                    .isFavorite!) {
                                                                  mainCubit.addOnlineCourseToFav(
                                                                      online_course_list![
                                                                              index]
                                                                          .id
                                                                          .toString());
                                                                } else {
                                                                  mainCubit.removeOnlineCourseToFav(
                                                                      online_course_list![
                                                                              index]
                                                                          .id
                                                                          .toString());
                                                                }
                                                              },
                                                              child: online_course_list![
                                                                          index]
                                                                      .isFavorite!
                                                                  ? SvgPicture.asset(
                                                                      'assets/icons/star_colored.svg',
                                                                      color:
                                                                          yelloCollor)
                                                                  : SvgPicture
                                                                      .asset(
                                                                          "assets/icons/starbroken.svg"),
                                                            ),
                                                          ),
                                                          Container(
                                                            height: 40.h,
                                                            width: 100.h,
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    yelloCollor,
                                                                borderRadius: BorderRadiusDirectional.only(
                                                                    topStart: Radius
                                                                        .circular(
                                                                            25))),
                                                            child: Center(
                                                                child: Text(
                                                              online_course_list![
                                                                          index]
                                                                      .isPurchased!
                                                                  ? "watch".tr
                                                                  : "reserve"
                                                                      .tr,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13.sp),
                                                            )),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            })),
                                Container(
                                  margin: EdgeInsetsDirectional.only(
                                      top: 20.h, start: 10.w, end: 10.w),
                                  child: Text(
                                    'recorded_courses'.tr,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: darkBlue,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Container(
                                    height: 150.h,
                                    margin: EdgeInsetsDirectional.only(
                                        start: 5.w, end: 5.w),
                                    child: offlineCourses_list!.length == 0
                                        ? Text("nodata".tr)
                                        : ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                offlineCourses_list!.length,
                                            itemBuilder: (context, index) {
                                              return OfflineCourseItem(
                                                addToFav: mainCubit
                                                    .addRecordedCourseToFav,
                                                removeFromFav: mainCubit
                                                    .removeRecordedCourseFromFav,
                                                offline_course_list:
                                                    offlineCourses_list![index],
                                                mainCubit: mainCubit,
                                              );
                                            })),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Container(
                                  margin: EdgeInsetsDirectional.only(
                                      top: 20.h, start: 10.w, end: 10.w),
                                  child: Text(
                                    'books_and_writings'.tr,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: darkBlue,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Container(
                                  height: 250.h,
                                  margin: EdgeInsetsDirectional.only(
                                      start: 10.w, end: 10.w),
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: books_list!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return BooksItem(
                                          books_list: books_list![index],
                                          addToFav: (String id) =>
                                              mainCubit.addBookToFav(id),
                                          removeFromFav: (String id) =>
                                              mainCubit.removeBookToFav(id),
                                          mainCubit: mainCubit,
                                        );
                                      }),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                );
              },
            )),
      ),
    );
  }
}
