import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../custom_widgets/custom_dialogs/nodata.dart';
import '../../../../shared_components/colors.dart';
import '../cubit/myLibrary_cubit.dart';
import '../cubit/myLibrary_states.dart';
import 'consultation_item.dart';

class AudioConsultationList extends StatefulWidget {
  const AudioConsultationList({Key? key}) : super(key: key);

  @override
  State<AudioConsultationList> createState() => _AudioConsultationListState();
}

class _AudioConsultationListState extends State<AudioConsultationList> {

  @override
  void initState() {
    context.read<MyLibraryCubit>().getAudioConsultations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyLibraryCubit, MyLibraryStates>(
        buildWhen: (previous, current) => current is MyLibraryAudioStates,
        builder: (context, state) {
          final cubit = MyLibraryCubit.get(context);
          if (state is MyLibraryAudioLoadingState) {
            return Center(
                child: CircularProgressIndicator(
                  color: mainColor,
                ));
          } else if (state is MyLibraryAudioErrorState) {
            return Center(
              child: Text(
                state.errorMsg,
                style: TextStyle(color: mainColor, fontSize: 20.sp),
              ),
            );
          } else {
            if (cubit.audioData == null || cubit.audioData?.length == 0) {
              return Center(
                child: NoData(
                  img: "assets/icons/audio_consultation.svg",
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: cubit.audioData?.length,
                  itemBuilder: (context, index) {
                    return ConsultationItem(
                    reply: cubit.audioData?[index].reply,
                    price: cubit.audioData?[index].price ?? "",
                    consultationType: "audio_consultation".tr,
                    status: cubit.audioData?[index].status ?? "",
                    time: (cubit.audioData?[index].date ?? "") +
                        " " +
                        (cubit.audioData?[index].time ?? ""),
                      delayedTime:
                      '${cubit.audioData?[index].delayedDate ?? ""} ${cubit.audioData?[index].delayedTime ?? ""}',
                      delayed: cubit.audioData?[index].delayed ?? false,
                  );
                  });
            }
          }
        });
  }
}
