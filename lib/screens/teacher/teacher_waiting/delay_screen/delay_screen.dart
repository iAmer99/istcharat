import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:istchrat/custom_widgets/custom_dialogs/failed_dialog/failed_dialog.dart';
import 'package:istchrat/custom_widgets/custom_dialogs/success_dialog/custom_success_dialog.dart';
import 'package:istchrat/screens/consultation_screen/widgets/day_item.dart';
import 'package:istchrat/screens/consultation_screen/widgets/time_item.dart';
import 'package:istchrat/screens/consultation_screen/widgets/title_text.dart';
import 'package:istchrat/screens/teacher/logs/cubit/logs_cubit.dart';
import 'package:istchrat/screens/teacher/logs/cubit/logs_states.dart';
import 'package:istchrat/screens/teacher/logs/log_item.dart';
import 'package:istchrat/screens/teacher/teacher_waiting/delay_screen/DelayDateModel.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:istchrat/shared_components/widgets/custom_app_bar.dart';
import 'package:istchrat/shared_components/widgets/rounded_yellow_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class DelayScreen extends StatelessWidget {
  DelayScreen(
      {Key? key,
      this.mobile,
      this.price,
      this.name,
      this.status,
      this.consultationType,
      this.date,
      this.categoryKey,
      this.id})
      : super(key: key);
  String? consultationType, status, name, price, date, mobile, categoryKey, id;
  DelayDateModel? dateModel;
  bool delayLoading = true;
  LogsCubit? cubit;
  Months? selectedMonth;
  final currentMonth = DateTime.now();

  @override
  Widget build(BuildContext context) {
    print(categoryKey);
    print(categoryKey);
    return BlocProvider(
      create: (context) => LogsCubit()
        ..getDelayDate("${currentMonth.month}", "30", categoryKey!),
      child: BlocConsumer<LogsCubit, LogsStates>(
        listener: (context, state) {
          if (state is AcceptedSuccessfullyState) {
            Navigator.pop(context);
            Get.defaultDialog(
              title: "",
              content: CustomSuccessDialog(
                message: state.message,
              ),
            );
          } else if (state is AcceptedErrorState) {
            failedDialog(context: context, message: state.errorMsg);
          }
        },
        builder: (context, state) {
          cubit = LogsCubit.get(context);
          dateModel = cubit!.dateModel;
          delayLoading = cubit!.delayLoading;
          selectedMonth = cubit!.selectedMonth;
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: CustomAppBar.appBar(context, text: "delay".tr),
            body: delayLoading == true
                ? Center(child: CircularProgressIndicator())
                : ModalProgressHUD(
                    inAsyncCall: state is AcceptedLoadingState,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LogItem(
                            status: status,
                            mobile: mobile,
                            date: date,
                            price: price,
                            name: name,
                            consultationType: consultationType,
                            showButton: false,
                            navigate: false,
                            onEndLoading: () {},
                            onStartLoading: () {},
                          ),
                          SizedBox(
                            height: 10.w,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton<Months>(
                                          value: selectedMonth,
                                          iconDisabledColor: mainColor,
                                          iconEnabledColor: mainColor,
                                          items: dateModel!.data!.months!
                                              .map((month) =>
                                                  DropdownMenuItem<Months>(
                                                    child: Text(
                                                      month.value.toString(),
                                                      style: const TextStyle(
                                                          color: mainColor),
                                                    ),
                                                    value: month,
                                                  ))
                                              .toList(),
                                          onChanged: (value) {
                                            cubit!
                                                .checkMonthSelectedIndex(value);
                                            cubit!.getDelayDateByMonth(
                                                value!.key.toString(),
                                                "30",
                                                value,
                                                categoryKey!);
                                          }),
                                    ),
                                    SizedBox(
                                      height: 80.h,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              dateModel!.data!.days!.length,
                                          itemBuilder: (context, index) {
                                            return DayItem(
                                              borderColor:
                                                  cubit!.selectedIndex == index
                                                      ? mainColor
                                                      : grey,
                                              containerColor:
                                                  cubit!.selectedIndex == index
                                                      ? mainColor
                                                      : Colors.white,
                                              daysColor:
                                                  cubit!.selectedIndex == index
                                                      ? Colors.white
                                                      : grey,
                                              dayKeyColor:
                                                  cubit!.selectedIndex == index
                                                      ? Colors.white
                                                      : Colors.black,
                                              onPress: () {
                                                cubit!.checkDaySelectedIndex(
                                                    index);
                                                cubit!.getDelayDateByDay(
                                                    cubit!.selectedMonth!.key
                                                        .toString(),
                                                    "30",
                                                    cubit!.selectedMonth!,
                                                    categoryKey!,
                                                    dateModel?.data?.days?[index].key ?? ""
                                                );
                                              },
                                              daysKey: dateModel!
                                                  .data!.days![index].key,
                                              daysValue: dateModel!
                                                  .data!.days![index].value,
                                            );
                                          }),
                                    ),
                                    SizedBox(
                                      height: 30.w,
                                    ),
                                    Row(
                                      children: [
                                        TitleText(title: "choose_time".tr),
                                        SizedBox(
                                          width: 15.w,
                                        ),
                                        Text(
                                          "time_zone".tr,
                                          style: TextStyle(
                                              color: yelloCollor,
                                              fontSize: 15.h),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 60.h,
                                      child: ListView.builder(
                                          itemCount:
                                              dateModel!.data!.times!.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2.0),
                                              child: TimeItem(
                                                  containerColor:
                                                      cubit!.timeSelectedIndex ==
                                                              index
                                                          ? mainColor
                                                          : Colors.white,
                                                  borderColor:
                                                      cubit!.timeSelectedIndex ==
                                                              index
                                                          ? mainColor
                                                          : lightGrey,
                                                  textColor:
                                                      cubit!.timeSelectedIndex ==
                                                              index
                                                          ? Colors.white
                                                          : grey,
                                                  onPress: () {
                                                    cubit!
                                                        .checkTimeSelectedIndex(
                                                            index);
                                                  },
                                                  time: dateModel!.data!
                                                      .times![index].value),
                                            );
                                          }),
                                    ),
                                    SizedBox(
                                      height: 30.w,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 80.h,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0),
                                child: RoundedYellowButton(
                                  text: "delay_appointment".tr,
                                  onTap: () {
                                    cubit!.acceptOrDecline(
                                        categoryKey!,
                                        id!,
                                        "delayed",
                                        "",
                                        currentMonth.year.toString() +
                                            "-" +
                                            selectedMonth!.key.toString() +
                                            "-" +
                                            dateModel!.data!
                                                .days![cubit!.selectedIndex].key
                                                .toString(),
                                        dateModel!
                                            .data!
                                            .times![cubit!.timeSelectedIndex]
                                            .key
                                            .toString(),
                                        "pending",
                                        '');
                                  },
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
