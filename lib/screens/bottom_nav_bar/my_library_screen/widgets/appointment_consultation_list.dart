import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../custom_widgets/custom_dialogs/nodata.dart';
import '../../../../shared_components/colors.dart';
import '../cubit/myLibrary_cubit.dart';
import '../cubit/myLibrary_states.dart';
import 'consultation_item.dart';


class AppointmentConsultationList extends StatefulWidget {
  const AppointmentConsultationList({Key? key}) : super(key: key);

  @override
  State<AppointmentConsultationList> createState() => _AppointmentConsultationListState();
}

class _AppointmentConsultationListState extends State<AppointmentConsultationList> {

  @override
  void initState() {
    context.read<MyLibraryCubit>().getAppointmentConsultations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyLibraryCubit, MyLibraryStates>(
        buildWhen: (previous, current) => current is MyLibraryAppointmentStates,
        builder: (context, state) {
          final cubit = MyLibraryCubit.get(context);
          if (state is MyLibraryAppointmentLoadingState) {
            return Center(
                child: CircularProgressIndicator(
                  color: mainColor,
                ));
          } else if (state is MyLibraryAppointmentErrorState) {
            return Center(
              child: Text(
                state.errorMsg,
                style: TextStyle(color: mainColor, fontSize: 20.sp),
              ),
            );
          } else {
            if (cubit.appointmentData == null || cubit.appointmentData?.length == 0) {
              return Center(
                child: NoData(
                  img: "assets/icons/clinic.svg",
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: cubit.appointmentData?.length,
                  itemBuilder: (context, index) => ConsultationItem(
                    reply: cubit.appointmentData?[index].reply,
                    price: cubit.appointmentData?[index].price ?? "",
                    consultationType: "appointment_consultation".tr,
                    status: cubit.appointmentData?[index].status ?? "",
                    time: (cubit.appointmentData?[index].date ?? "") +
                        " " +
                        (cubit.appointmentData?[index].time ?? ""),
                    delayedTime:
                    '${cubit.appointmentData?[index].delayedDate ?? ""} ${cubit.appointmentData?[index].delayedTime ?? ""}',
                    delayed: cubit.appointmentData?[index].delayed ?? false,
                  ));
            }
          }
        });
  }
}
