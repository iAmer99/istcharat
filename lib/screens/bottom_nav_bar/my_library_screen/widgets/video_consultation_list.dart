import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:istchrat/custom_widgets/custom_dialogs/nodata.dart';
import 'package:istchrat/screens/bottom_nav_bar/my_library_screen/cubit/myLibrary_cubit.dart';
import 'package:istchrat/screens/bottom_nav_bar/my_library_screen/cubit/myLibrary_states.dart';
import 'package:istchrat/screens/bottom_nav_bar/my_library_screen/widgets/consultation_item.dart';
import 'package:istchrat/shared_components/colors.dart';

class VideoConsultationList extends StatefulWidget {
  const VideoConsultationList({Key? key}) : super(key: key);

  @override
  State<VideoConsultationList> createState() => _VideoConsultationListState();
}

class _VideoConsultationListState extends State<VideoConsultationList> {
  @override
  void initState() {
    context.read<MyLibraryCubit>().getVideoConsultations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyLibraryCubit, MyLibraryStates>(
        buildWhen: (previous, current) => current is MyLibraryVideoStates,
        builder: (context, state) {
          final cubit = MyLibraryCubit.get(context);
          if (state is MyLibraryVideoLoadingState) {
            return Center(
                child: CircularProgressIndicator(
              color: mainColor,
            ));
          } else if (state is MyLibraryVideoErrorState) {
            return Center(
              child: Text(
                state.errorMsg,
                style: TextStyle(color: mainColor, fontSize: 20.sp),
              ),
            );
          } else if (state is! MyLibraryVideoStates) {
            if (cubit.videoData?.length == 0) {
              return Center(
                child: NoData(
                  img: "assets/icons/video.svg",
                ),
              );
            } else if (cubit.videoData == null) {
              return Center(
                  child: CircularProgressIndicator(
                color: mainColor,
              ));
            } else {
              return ListView.builder(
                  itemCount: cubit.videoData?.length,
                  itemBuilder: (context, index) => ConsultationItem(
                        reply: cubit.videoData?[index].reply,
                        price: cubit.videoData?[index].price ?? "",
                        consultationType: "video_consultation".tr,
                        status: cubit.videoData?[index].status ?? "",
                        time: (cubit.videoData?[index].date ?? "") +
                            " " +
                            (cubit.videoData?[index].time ?? ""),
                        delayedTime:
                            '${cubit.videoData?[index].delayedDate ?? ""} ${cubit.videoData?[index].delayedTime ?? ""}',
                        delayed: cubit.videoData?[index].delayed ?? false,
                      ));
            }
          } else {
            if (cubit.videoData == null || cubit.videoData?.length == 0) {
              return Center(
                child: NoData(
                  img: "assets/icons/video.svg",
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: cubit.videoData?.length,
                  itemBuilder: (context, index) => ConsultationItem(
                        reply: cubit.videoData?[index].reply,
                        price: cubit.videoData?[index].price ?? "",
                        consultationType: "video_consultation".tr,
                        status: cubit.videoData?[index].status ?? "",
                        time: (cubit.videoData?[index].date ?? "") +
                            " " +
                            (cubit.videoData?[index].time ?? ""),
                    delayedTime:
                    '${cubit.videoData?[index].delayedDate ?? ""} ${cubit.videoData?[index].delayedTime ?? ""}',
                    delayed: cubit.videoData?[index].delayed ?? false,
                      ));
            }
          }
        });
  }
}
