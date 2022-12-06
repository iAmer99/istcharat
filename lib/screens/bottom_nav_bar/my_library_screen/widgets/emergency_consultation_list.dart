import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../custom_widgets/custom_dialogs/nodata.dart';
import '../../../../shared_components/colors.dart';
import '../cubit/myLibrary_cubit.dart';
import '../cubit/myLibrary_states.dart';
import 'consultation_item.dart';

class EmergencyConsultationList extends StatefulWidget {
  const EmergencyConsultationList({Key? key}) : super(key: key);

  @override
  State<EmergencyConsultationList> createState() => _EmergencyConsultationListState();
}

class _EmergencyConsultationListState extends State<EmergencyConsultationList> {

  @override
  void initState() {
    context.read<MyLibraryCubit>().getEmergencyConsultations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyLibraryCubit, MyLibraryStates>(
        buildWhen: (previous, current) => current is MyLibraryEmergencyStates,
        builder: (context, state) {
          final cubit = MyLibraryCubit.get(context);
          if (state is MyLibraryEmergencyLoadingState) {
            return Center(
                child: CircularProgressIndicator(
                  color: mainColor,
                ));
          } else if (state is MyLibraryEmergencyErrorState) {
            return Center(
              child: Text(
                state.errorMsg,
                style: TextStyle(color: mainColor, fontSize: 20.sp),
              ),
            );
          } else {
            if (cubit.emergencyData == null || cubit.emergencyData?.length == 0) {
              return Center(
                child: NoData(
                  img: "assets/icons/emergency_consultation.svg",
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: cubit.emergencyData?.length,
                  itemBuilder: (context, index) => ConsultationItem(
                    reply: cubit.emergencyData?[index].reply,
                    price: cubit.emergencyData?[index].price ?? "",
                    consultationType: "emergency_consultation".tr,
                    status: cubit.emergencyData?[index].status ?? "",
                    time: (cubit.emergencyData?[index].date ?? "") +
                        " " +
                        (cubit.emergencyData?[index].time ?? ""),
                    delayedTime:
                    '${cubit.emergencyData?[index].delayedDate ?? ""} ${cubit.emergencyData?[index].delayedTime ?? ""}',
                    delayed: cubit.emergencyData?[index].delayed ?? false,
                    question: cubit.emergencyData?[index].question,
                  ));
            }

          }
        });
  }
}
