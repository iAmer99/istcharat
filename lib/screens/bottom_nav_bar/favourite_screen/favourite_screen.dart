import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:istchrat/custom_widgets/custom_container.dart';
import 'package:istchrat/screens/book_details/book_details.dart';
import 'package:istchrat/screens/bottom_nav_bar/favourite_screen/cubit/favourite_cubit.dart';
import 'package:istchrat/screens/bottom_nav_bar/favourite_screen/cubit/favourite_states.dart';
import 'package:istchrat/screens/course_details/course_details_screen.dart';
import 'package:istchrat/screens/course_details/online_details/online_course_details_screen.dart';
import 'package:istchrat/screens/login/login_screen.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:istchrat/shared_components/constants/constants.dart';

import '../../../custom_widgets/custom_dialogs/nodata.dart';
import '../../../shared_components/widgets/custom_app_bar.dart';

class FavouriteScreen extends StatefulWidget {
  FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  int selectedTap = 0;
  final box = GetStorage();

  checkSelectedTap(int index) {
    setState(() {
      selectedTap = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavouritesCubit>(
      create: (context) =>
      FavouritesCubit()
        ..getFavouriteRecordedCourses(
            box.read(Constants.accessToken.toString()) != null),
      child: BlocBuilder<FavouritesCubit, FavouritesStates>(
        builder: (context, state) {
          final cubit = FavouritesCubit.get(context);
          return SafeArea(
            child: Scaffold(
              appBar: CustomAppBar.appBar(
                context,
                text: "favourite".tr,
              ),
                backgroundColor: Colors.white,
                body: Column(
                  children: [
                    if(box.read(Constants.accessToken.toString()) !=
                        null) Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.h, vertical: 15.h),
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        height: 40.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: mainColor),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  checkSelectedTap(0);
                                  cubit.getFavouriteRecordedCourses(box.read(
                                      Constants.accessToken.toString()) !=
                                      null);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadiusDirectional
                                          .only(

                                        bottomStart: Radius.circular(25),
                                        topStart: Radius.circular(25),


                                      ),
                                      color: selectedTap == 0
                                          ? mainColor
                                          : Colors.white,
                                      border: Border.all(color: mainColor)),
                                  height: 40.h,
                                  child: Center(
                                      child: Text(
                                        "recorded_courses".tr,
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: selectedTap == 0
                                                ? Colors.white
                                                : mainColor),
                                      )),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  checkSelectedTap(1);
                                  cubit.getFavouriteOnlineCourses();
                                },
                                child: Container(
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: mainColor),
                                    color: selectedTap == 1
                                        ? mainColor
                                        : Colors.white,
                                  ),
                                  child: Center(
                                      child: Text(
                                        "online_courses".tr,
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: selectedTap == 1
                                                ? Colors.white
                                                : mainColor),
                                      )),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  checkSelectedTap(2);
                                  cubit.getFavouriteBooks();
                                },
                                child: Container(
                                  height: 40.h,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadiusDirectional
                                          .only(
                                        topEnd: Radius.circular(25),
                                        bottomEnd: Radius.circular(25),
                                      ),
                                      color: selectedTap == 2
                                          ? mainColor
                                          : Colors.white,
                                      border: Border.all(color: mainColor)),
                                  child: Center(
                                      child: Text(
                                        "books_and_writings".tr,
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: selectedTap == 2
                                                ? Colors.white
                                                : mainColor),
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    box.read(Constants.accessToken.toString()) != null
                        ? Expanded(child: tapsTrigger())
                        : Expanded(child: Center(child: NoData(login: true,),))
                  ],
                )),
          );
        },
      ),
    );
  }

  Widget recordedCourses() {
    return BlocBuilder<FavouritesCubit, FavouritesStates>(
      buildWhen: (prev, current) => current is FavouritesRecordedCoursesStates,
      builder: (context, state) {
        final FavouritesCubit cubit = FavouritesCubit.get(context);
        if (state is FavouriteRecordedCoursesErrorState) {
          return Center(child: Text(state.error));
        } else if (state is FavouriteRecordedCoursesSuccessState) {
          if (cubit.favouriteRecordedCourses!.data!.rows != null &&
              cubit.favouriteRecordedCourses!.data!.rows!.isNotEmpty) {
            return ListView.builder(
                itemCount: cubit.favouriteRecordedCourses!.data!.rows!.length,
                itemBuilder: (context, index) {
                  final item =
                  cubit.favouriteRecordedCourses!.data!.rows![index];
                  return Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 20.h, vertical: 8.h),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() =>
                            CourseDetailsScreen(
                              id: int.parse(item.modelId!),
                            ));
                      },
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        height: 110.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Colors.grey)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Container(
                                    height: 73.h,
                                    width: 73.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Image.network(
                                      item.image!,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * .4,
                                  child: Padding(
                                    padding:
                                    EdgeInsets.symmetric(vertical: 15.h),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            "${item.title == null ? "" : item
                                                .title}",
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                color: Colors.black),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        if(item.date != null) Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SvgPicture
                                                .asset(
                                                "assets/icons/calendar.svg"),
                                            SizedBox(
                                              width:
                                              8.w,
                                            ),
                                            Flexible(
                                              child:
                                              Text(
                                                "${item.date}",
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
                                            "${item.price == null ? "" : item
                                                .price} ${"USD".tr}",
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
                            Flexible(
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        cubit.removeRecordedCourseFromFav(
                                            item.modelId!);
                                      },
                                      child: SvgPicture.asset(
                                          "assets/icons/trash.svg"),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      height: 40.h,
                                      width: 100.h,
                                      decoration: BoxDecoration(
                                          color: yelloCollor,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(25))),
                                      child: Center(
                                          child: Text(
                                            item.is_purchased == true ?
                                            "watch".tr : "buy_now".tr,
                                            style: TextStyle(fontSize: 13.sp),
                                          )),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return Center(
                child: NoData(
                  img: "assets/icons/recordedcourse.svg",
                ));
          }
        } else {
          return const Center(
              child: CircularProgressIndicator(
                color: mainColor,
              ));
        }
      },
    );
  }

  Widget onlineCourses() {
    return BlocBuilder<FavouritesCubit, FavouritesStates>(
      buildWhen: (prev, current) => current is FavouritesOnlineCoursesStates,
      builder: (context, state) {
        final FavouritesCubit cubit = FavouritesCubit.get(context);
        if (state is FavouriteOnlineCoursesSuccessState) {
          if (cubit.favouriteOnlineCourses!.data!.rows != null &&
              cubit.favouriteOnlineCourses!.data!.rows!.isNotEmpty) {
            return ListView.builder(
                itemCount: cubit.favouriteOnlineCourses!.data!.rows!.length,
                itemBuilder: (context, index) {
                  final item = cubit.favouriteOnlineCourses!.data!.rows![index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(() =>
                          OnlineCourseDetailsScreen(
                            id: int.parse(item.modelId!),
                          ));
                    },
                    child: CustomContainer(
                      subTitle: item.is_purchased == true
                          ? "watch".tr
                          : "reserve".tr,
                      icon: "assets/icons/trash.svg",
                      image: "${item.image == null ? "" : item.image}",
                      date: item.date,
                      removeFromFav: () =>
                          cubit.removeOnlineCourseToFav(item.modelId!),
                      title: "${item.title == null ? "" : item.title}",
                      price: "${item.price == null ? "" : item.price}",
                    ),
                  );
                });
          } else {
            return Center(
                child: NoData(
                  img: "assets/icons/online-course.svg",
                ));
          }
        } else if (state is FavouriteOnlineCoursesErrorState) {
          return Center(child: Text(state.error));
        } else {
          return const Center(
              child: CircularProgressIndicator(
                color: mainColor,
              ));
        }
      },
    );
  }

  Widget booksAndWritings() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: BlocBuilder<FavouritesCubit, FavouritesStates>(
        buildWhen: (prev, current) => current is FavouritesBooksStates,
        builder: (context, state) {
          final FavouritesCubit cubit = FavouritesCubit.get(context);
          if (state is FavouriteBooksSuccessState) {
            if (cubit.favouriteBooks!.data!.rows != null &&
                cubit.favouriteBooks!.data!.rows!.isNotEmpty) {
              return GridView.builder(
                  itemCount: cubit.favouriteBooks!.data!.rows!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: .7),
                  itemBuilder: (context, index) {
                    final item = cubit.favouriteBooks!.data!.rows![index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() =>
                              BookDetails(
                                id: item.modelId!,
                              ));
                        },
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: lightGrey,
                              ),
                              borderRadius: BorderRadius.circular(25)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.w, vertical: 8.h),
                                    child: GestureDetector(
                                      onTap: () {
                                        cubit.removeBookToFav(item.modelId!);
                                      },
                                      child: SvgPicture.asset(
                                          "assets/icons/trash.svg"),
                                    ),
                                  ),
                                ],
                              ),
                              Image.network(
                                item.image!,
                                height: 100,
                                width: 110,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${item.title == null ? "" : item.title}",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 5.h,),
                                    if(item.date != null) Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
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
                                            "${item.date}",
                                            style: TextStyle(
                                                fontSize: 13.sp,
                                                color: Colors.grey),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5.h,),
                                    Text("${item.price} ${"USD".tr}",
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            color: yelloCollor,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Container(
                                  color: yelloCollor,
                                  height: 40.h,
                                  child: Center(
                                      child: Text(item.is_purchased == true
                                          ? "read_the_book".tr
                                          :
                                      "buy_now".tr,
                                        style: TextStyle(fontSize: 13.sp),
                                      )),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                  child: NoData(
                    img: "assets/icons/books.svg",
                  ));
            }
          } else if (state is FavouriteBooksErrorState) {
            return Center(child: Text(state.error));
          } else {
            return const Center(
                child: CircularProgressIndicator(
                  color: mainColor,
                ));
          }
        },
      ),
    );
  }

  tapsTrigger() {
    switch (selectedTap) {
      case 0:
        return recordedCourses();
      case 1:
        return onlineCourses();
      case 2:
        return booksAndWritings();
    }
  }
}
