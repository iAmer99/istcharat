import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:istchrat/custom_widgets/custom_container.dart';
import 'package:istchrat/custom_widgets/custom_dialogs/nodata.dart';
import 'package:istchrat/screens/book_details/book_details.dart';
import 'package:istchrat/screens/books_screens/cubit/books_cubit.dart';
import 'package:istchrat/screens/books_screens/cubit/books_state.dart';
import 'package:istchrat/screens/books_screens/models/book_model.dart';
import 'package:istchrat/screens/bottom_nav_bar/my_library_screen/cubit/myLibrary_cubit.dart';
import 'package:istchrat/screens/bottom_nav_bar/my_library_screen/myonline_course_item.dart';
import 'package:istchrat/screens/bottom_nav_bar/my_library_screen/widgets/appointment_consultation_list.dart';
import 'package:istchrat/screens/bottom_nav_bar/my_library_screen/widgets/audio_consultation_list.dart';
import 'package:istchrat/screens/bottom_nav_bar/my_library_screen/widgets/chat_consultation_list.dart';
import 'package:istchrat/screens/bottom_nav_bar/my_library_screen/widgets/emergency_consultation_list.dart';
import 'package:istchrat/screens/bottom_nav_bar/my_library_screen/widgets/faqs_consultation_list.dart';
import 'package:istchrat/screens/bottom_nav_bar/my_library_screen/widgets/video_consultation_list.dart';
import 'package:istchrat/screens/course_details/course_details_screen.dart';
import 'package:istchrat/screens/course_details/online_details/online_course_details_screen.dart';
import 'package:istchrat/screens/login/login_screen.dart';
import 'package:istchrat/screens/main/widgets/online_course_item.dart';
import 'package:istchrat/screens/online_course/cubit/online_state.dart';
import 'package:istchrat/screens/online_course/cubit/onlinecourse_cubit.dart';
import 'package:istchrat/screens/online_course/models/online_model.dart';
import 'package:istchrat/screens/pdf_screen/pdf_screen.dart';
import 'package:istchrat/screens/recorded_course/cubit/recorded_course_cubit.dart';
import 'package:istchrat/screens/recorded_course/cubit/recorded_state.dart';
import 'package:istchrat/screens/recorded_course/models/recorded_course_model.dart';
import 'package:istchrat/screens/recorded_course/models/recorded_course_model.dart';
import 'package:istchrat/screens/recorded_course/models/recorded_course_model.dart';

import 'package:istchrat/shared_components/colors.dart';
import 'package:istchrat/shared_components/constants/constants.dart';
import 'package:istchrat/shared_components/widgets/custom_app_bar.dart';

class MyLibraryScreen extends StatefulWidget {
  const MyLibraryScreen({Key? key, this.index = 0}) : super(key: key);
  final int index;

  @override
  State<MyLibraryScreen> createState() => _MyLibraryScreenState();
}

class _MyLibraryScreenState extends State<MyLibraryScreen> {
  int selectedTap = 0;
  late RecordedCourseCubit recordedCourseCubit;
  Recorded_course_model? data = new Recorded_course_model();
  bool isLoading = true;
  List<recordedCourses>? recordedList;
  late OnlineCourseCubit onlineCourseCubit;
  OnlineModel? online_data = new OnlineModel();
  List<onlinecourses>? onlinecourselist;
  bool showSearch = false;
  String keyword = "";

  //
  late BooksCubit booksCubit;
  BookModel? books_data = new BookModel();
  List<books>? booksList;
  final box = GetStorage();

  checkSelectedTap(int index) {
    setState(() {
      selectedTap = index;
    });
  }

  @override
  void initState() {
    selectedTap = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar.appBar(
            context,
            text: "my_library".tr,
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
          body: MultiBlocProvider(
            providers: [
              BlocProvider<MyLibraryCubit>(
                  create: (context) => MyLibraryCubit(),),
              BlocProvider(
                  create: (context) => RecordedCourseCubit()
                    ..getMyRecordedList(
                        box.read(Constants.accessToken.toString()) != null)),
              BlocProvider(
                  create: (context) => OnlineCourseCubit()
                    ..getMyOnlineList(
                        box.read(Constants.accessToken.toString()) != null)),
              BlocProvider(
                  create: (context) => BooksCubit()
                    ..getMyBooksList(
                        box.read(Constants.accessToken.toString()) != null)),
            ],
            child: Column(
              children: [
                /*  Container(
                  height: 60.h,
                  width: double.infinity,
                  color: Color(0xffFAFAFA),
                  child: Center(
                      child: Text(
                    "my_library".tr,
                    style: TextStyle(fontSize: 15.sp),
                  )),
                ),
                SizedBox(
                  height: 10.h,
                ), */
                if (box.read(Constants.accessToken.toString()) != null)
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.h, vertical: 15.h),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildTypeTap(
                            index: 0,
                            title: "video_consultation".tr,
                            icon: "assets/icons/video.svg",
                          ),
                          _buildTypeTap(
                            index: 1,
                            title: "audio_consultation".tr,
                            icon: "assets/icons/audio_consultation.svg",
                          ),
                          _buildTypeTap(
                              index: 2,
                              title: "text_conversation".tr,
                              icon: "assets/icons/chat.svg"),
                          _buildTypeTap(
                            index: 3,
                            title: "online_courses".tr,
                            icon: "assets/icons/online-course.svg",
                          ),
                          _buildTypeTap(
                            index: 4,
                            title: "recorded_courses".tr,
                            icon: "assets/icons/recordedcourse.svg",
                          ),
                          _buildTypeTap(
                            index: 5,
                            title: "books_and_writings".tr,
                            icon: "assets/icons/books.svg",
                          ),
                          _buildTypeTap(
                            index: 6,
                            title: "question_and_answer".tr,
                            icon: "assets/icons/question.svg",
                          ),
                          _buildTypeTap(
                            index: 7,
                            title: "appointment_consultation".tr,
                            icon: "assets/icons/clinic.svg",
                          ),
                          _buildTypeTap(
                            index: 8,
                            title: "emergency_consultation".tr,
                            icon: "assets/icons/emergency_consultation.svg",
                          ),
                        ],
                      ),
                    ),
                  ),
                box.read(Constants.accessToken.toString()) != null
                    ? Expanded(child: tapsTrigger())
                    : Expanded(
                        child: Center(
                        child: NoData(
                          login: true,
                        ),
                      ))
              ],
            ),
          )),
    );
  }

  Widget _buildTypeTap({
    required int index,
    required String title,
    required String icon,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: GestureDetector(
        onTap: () {
          checkSelectedTap(index);
        },
        child: Container(
          width: 120.w,
          height: 110.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: selectedTap == index ? mainColor : Colors.white,
              border: Border.all(color: mainColor)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
            child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  icon,
                  height: 40.h,
                  color: selectedTap == index ? Colors.white : null,
                ),
                SizedBox(
                  height: 7.h,
                ),
                Flexible(
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: selectedTap == index ? Colors.white : mainColor),
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }

  Widget recordedCourse() {
    return BlocConsumer<RecordedCourseCubit, RecordedState>(
        builder: (ctx, state) {
          recordedCourseCubit = RecordedCourseCubit.get(ctx);
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
          return isLoading == true
              ? Center(child: CircularProgressIndicator())
              : recordedList!.length == 0 || data!.data!.recordedList == null
                  ? Center(
                      child: NoData(
                      img: "assets/icons/recordedcourse.svg",
                    ))
                  : ListView.builder(
                      itemCount: recordedList!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.h, vertical: 8.h),
                          child: GestureDetector(
                              onTap: () {
                                Get.to(() => CourseDetailsScreen(
                                      id: recordedList![index].id,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w,
                                                vertical: 15.h),
                                            child: Container(
                                              height: 73.h,
                                              width: 73.h,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.grey,
                                              ),
                                              child: Image.network(
                                                recordedList![index].image!,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .4,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 15.h),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${recordedList![index].title}",
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        color: Colors.black),
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
                                                          width: 3.w,
                                                        ),
                                                        Text(
                                                          "${recordedList![index].date.toString()}",
                                                          style: TextStyle(
                                                              fontSize: 13.sp,
                                                              color:
                                                                  Colors.grey),
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
                                                          fontSize: 15.sp,
                                                          color: yelloCollor,
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
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if (recordedList![index]
                                                      .is_favorite ==
                                                  false) {
                                                recordedCourseCubit
                                                    .addMyRecordedTofav(
                                                        recordedList![index]
                                                            .id
                                                            .toString());
                                              } else {
                                                recordedCourseCubit
                                                    .removeMyRecordedFromFav(
                                                        recordedList![index]
                                                            .id
                                                            .toString());
                                              }
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: recordedList![index]
                                                      .is_favorite!
                                                  ? SvgPicture.asset(
                                                      'assets/icons/star_colored.svg',
                                                      color: yelloCollor)
                                                  : SvgPicture.asset(
                                                      "assets/icons/starbroken.svg"),
                                            ),
                                          ),
                                          Container(
                                            height: 40.h,
                                            width: 100.h,
                                            decoration: BoxDecoration(
                                                color: yelloCollor,
                                                borderRadius:
                                                    BorderRadiusDirectional
                                                        .only(
                                                            topStart:
                                                                Radius.circular(
                                                                    25))),
                                            child: Center(
                                                child: Text(
                                              "watch".tr,
                                              style: TextStyle(fontSize: 13.sp),
                                            )),
                                          )
                                        ],
                                      )
                                    ],
                                  ))),
                        );
                      });
        },
        listener: (ctx, state) {});
  }

  Widget onlineCourses() {
    return BlocConsumer<OnlineCourseCubit, OnlineState>(
        builder: (context, state) {
          onlineCourseCubit = OnlineCourseCubit.get(context);
          online_data = onlineCourseCubit.online_model;
          isLoading = onlineCourseCubit.isLoading;
          if (isLoading == false) {
            if (keyword.isEmpty) {
              onlinecourselist = online_data!.data!.onlineList;
            } else {
              onlinecourselist = online_data!.data!.onlineList!
                  .where((element) => element.title!.toLowerCase().contains(keyword.toLowerCase()))
                  .toList();
            }
          }
          return isLoading == true
              ? Center(child: CircularProgressIndicator())
              : onlinecourselist!.length == 0 ||
                      online_data!.data!.onlineList == null
                  ? Center(
                      child: NoData(
                      img: "assets/icons/online-course.svg",
                    ))
                  : ListView.builder(
                      itemCount: onlinecourselist!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              Get.to(OnlineCourseDetailsScreen(
                                id: onlinecourselist![index].id,
                              ));
                            },
                            child: MyOnlineCourseItem(
                              online_course_list: onlinecourselist![index],
                            ));
                      });
        },
        listener: (context, state) {});
  }

  Widget booksAndWritings() {
    return BlocConsumer<BooksCubit, BooksState>(
        builder: (context, state) {
          booksCubit = BooksCubit.get(context);
          books_data = booksCubit.book_model;
          isLoading = booksCubit.isLoading;
          if (isLoading == false) {
            if (keyword.isEmpty) {
              booksList = books_data!.data!.book_list!;
            } else {
              booksList = books_data!.data!.book_list!
                  .where((element) => element.title!.toLowerCase().contains(keyword.toLowerCase()))
                  .toList();
            }
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: isLoading == true
                ? Center(child: CircularProgressIndicator())
                : booksList!.length == 0 || books_data!.data!.book_list == null
                    ? Center(
                        child: NoData(
                        img: "assets/icons/books.svg",
                      ))
                    : GridView.builder(
                        itemCount: booksList!.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .7),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Get.to(BookDetails(
                          id: booksList![index].id.toString(),
                        ));
                      },
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: lightGrey,
                            ),
                            borderRadius:
                            BorderRadius.circular(25)),
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            Image.network(
                              "${booksList![index].image}",
                              height: 100,
                              width: 110,
                            ),
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 8.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "${booksList![index].title}"),
                                  SizedBox(height: 5.h,),
                                  if(booksList![index].publishedAt != null) Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SvgPicture
                                          .asset(
                                          "assets/icons/calendar.svg"),
                                      SizedBox(
                                        width:
                                        3.w,
                                      ),
                                      SizedBox(height: 5.h,),
                                      Flexible(
                                        child:
                                        Text(
                                          "${booksList![index].publishedAt}",
                                          style: TextStyle(
                                              fontSize: 13.sp,
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5.h,),
                                  Text("${booksList![index].price} ${"USD".tr}",
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          color: yelloCollor,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            Container(
                              color: yelloCollor,
                              height: 30.h,
                              child: Center(
                                  child: Text(booksList![index].isPurchased==true?
                                  "read_the_book".tr:"buy_now".tr,
                                    style: TextStyle(
                                        fontSize: 13.sp),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                       /* gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: .7),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(BookDetails(
                                  id: booksList![index].id.toString(),
                                ));
                              },
                              child: Container(
                                margin: EdgeInsetsDirectional.only(
                                    start: 5.w, end: 5.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      flex: 4,
                                      child: Container(
                                        width: 130.w,
                                        padding: EdgeInsetsDirectional.all(6),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              width: 1.0, color: lightGrey),
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10)),
                                        ),
                                        // color: Colors.white,
                                        //height: 180.h,
                                        child: Column(
                                          children: [
                                            Container(
                                              alignment:
                                                  AlignmentDirectional.topStart,
                                              child: GestureDetector(
                                                onTap: () {
                                                  if (!booksList![index]
                                                      .isFavorite!) {
                                                    booksCubit.addMyBooksTofav(
                                                        booksList![index]
                                                            .id
                                                            .toString());
                                                  } else {
                                                    booksCubit
                                                        .removeMybooksFromFav(
                                                            booksList![index]
                                                                .id
                                                                .toString());
                                                  }
                                                },
                                                child: booksList![index]
                                                        .isFavorite!
                                                    ? SvgPicture.asset(
                                                        'assets/icons/star_colored.svg',
                                                        color: yelloCollor)
                                                    : SvgPicture.asset(
                                                        "assets/icons/starbroken.svg"),
                                              ),
                                            ),
                                            Container(
                                              height: 110.h,
                                              child: Image.network(
                                                "${booksList![index].image}",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Flexible(
                                              child: Text(
                                                "${booksList![index].title}",
                                                style: TextStyle(
                                                  fontSize: 11.w,
                                                  fontWeight: FontWeight.normal,
                                                  color: darkGrey,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Flexible(
                                              child: Text(
                                                "${booksList![index].price}" +
                                                    " " +
                                                    "${booksList![index].currency}",
                                                style: TextStyle(
                                                  fontSize: 16.h,
                                                  fontWeight: FontWeight.bold,
                                                  color: yelloCollor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: GestureDetector(
                                        onTap: () {
                                          // Get.to(PdfScreen(pdfUrl: booksList[index].url));
                                          Get.to(BookDetails(
                                            id: booksList![index].id.toString(),
                                          ));
                                        },
                                        child: Container(
                                          width: 130.w,
                                          padding: EdgeInsetsDirectional.all(6),
                                          margin: EdgeInsetsDirectional.only(
                                              bottom: 10.h),
                                          decoration: BoxDecoration(
                                            color: yelloCollor,
                                            border: Border.all(
                                                width: 1.0, color: lightGrey),
                                            borderRadius:
                                                const BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(5),
                                                    bottomLeft:
                                                        Radius.circular(5)),
                                          ),
                                          child: Center(
                                              child: Text(
                                            "read_the_book".tr,
                                            style: TextStyle(
                                                fontSize: 13.sp,
                                                color: darkGrey,
                                                fontWeight: FontWeight.bold),
                                          )),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ); */
                        }),
          );
        },
        listener: (context, state) {});
  }

  tapsTrigger() {
    switch (selectedTap) {
      case 0:
        return VideoConsultationList();
      case 1:
        return AudioConsultationList();
      case 2:
        return ChatConsultationList();
      case 3:
        return onlineCourses();
      case 4:
        return recordedCourse();
      case 5:
        return booksAndWritings();
      case 6:
        return FaqsConsultationList();
      case 7:
        return AppointmentConsultationList();
      case 8:
        return EmergencyConsultationList();
    }
  }
}
