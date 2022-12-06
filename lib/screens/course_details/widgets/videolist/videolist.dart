import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:istchrat/custom_widgets/custom_dialogs/nodata.dart';
import 'package:istchrat/screens/course_details/widgets/videolist/cubit/videos_list_cubit.dart';
import 'package:istchrat/screens/course_details/widgets/videolist/cubit/videos_list_states.dart';
import 'package:istchrat/screens/course_details/widgets/videolist/vedioItem.dart';
import 'package:istchrat/shared_components/widgets/custom_app_bar.dart';

import '../../../../shared_components/colors.dart';
import '../../../../shared_components/helper_functions.dart';
import '../../../consultation_screen/widgets/consultant_details.dart';

class VideoList extends StatelessWidget {
  final String type;
  final String id;
  final String name;
  final String title;

  const VideoList(
      {Key? key,
      required this.type,
      required this.id,
      required this.name,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VideosListCubit()..getList(segment: type, id: id),
      child: BlocBuilder<VideosListCubit, VideosListStates>(
        builder: (context, state) {
          final cubit = VideosListCubit.get(context);
          return Scaffold(
              appBar: CustomAppBar.appBar(context, text: "watch_course".tr),
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      margin:
                          EdgeInsetsDirectional.only(start: 15.w, end: 15.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.h),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 13.w, vertical: 5.h),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 99.h,
                              width: 76.w,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(14.h),
                                child: Image.asset(
                                  "assets/images/avatar.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15.w),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/person.svg',
                                        height: 16.h,
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Expanded(
                                          child: Text(
                                        name,
                                        style: TextStyle(
                                            color: grey, fontSize: 15.w),
                                      )),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        child: state is VideosListLoadingState
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: mainColor,
                                ),
                              )
                            : (state is VideosListErrorState
                                ? Center(
                                    child: Text(
                                      state.msg,
                                      style: TextStyle(
                                          color: mainColor, fontSize: 15.sp),
                                    ),
                                  )
                                : cubit.list.length == 0
                                    ? Center(
                                        child: NoData(
                                          img: getIconPath(type),
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: cubit.list.length,
                                        itemBuilder: (context, index) {
                                          return VideoItem(
                                            index: (index + 1).toString(),
                                            title: cubit.list[index].title,
                                            url: cubit.list[index].courseLink ??
                                                "",
                                            date: cubit.list[index].date,
                                          );
                                        })),)
                  ],
                ),
              ));
        },
      ),
    );
  }
}
