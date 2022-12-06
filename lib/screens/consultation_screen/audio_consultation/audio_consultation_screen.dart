import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:istchrat/custom_widgets/custom_dialogs/failed_dialog/failed_dialog.dart';
import 'package:istchrat/custom_widgets/custom_dialogs/success_dialog/success_dialog.dart';
import 'package:istchrat/custom_widgets/net_failed_widget.dart';
import 'package:istchrat/screens/confirm_payment/audio/audio_confirm_appointment_screen.dart';
import 'package:istchrat/screens/confirm_payment/video_confirm_appointment_screen.dart';
import 'package:istchrat/screens/consultation_screen/audio_consultation/audio_consultation_cubit/audio_consultation_cubit.dart';
import 'package:istchrat/screens/consultation_screen/audio_consultation/audio_consultation_cubit/audio_consultation_states.dart';
import 'package:istchrat/screens/consultation_screen/audio_consultation/repo/AudioConsultationModel.dart';
import 'package:istchrat/screens/consultation_screen/widgets/consultant_details.dart';
import 'package:istchrat/screens/consultation_screen/widgets/day_item.dart';
import 'package:istchrat/screens/consultation_screen/widgets/duration_item.dart';
import 'package:istchrat/screens/login/login_screen.dart';
import 'package:istchrat/shared_components/constants/constants.dart';
import 'package:istchrat/shared_components/widgets/custom_app_bar.dart';
import 'package:istchrat/shared_components/widgets/rounded_yellow_button.dart';
import 'package:istchrat/screens/consultation_screen/widgets/time_item.dart';
import 'package:istchrat/screens/consultation_screen/widgets/title_text.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../confirm_payment/widgets/success_dialog_content.dart';

class AudioConsultationScreen extends StatelessWidget {
  bool isLoading = false;
  bool isSelected = false;
  AudioConsultationCubit? consultationCubit;
  AudioConsultationModel? audioConsultationModel;
  Months? selectedMonth;
  int selectedIndex = 0;
  final box = GetStorage();
  bool isError = false;
  final currentMonth = DateTime.now().month;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AudioConsultationCubit()
        ..getAudioConsultationData(
            currentMonth.toString(), "15", DateTime.now().day.toString()),
      child: BlocConsumer<AudioConsultationCubit, AudioConsultationStates>(
          builder: (context, state) {
        consultationCubit = AudioConsultationCubit.get(context);
        isLoading = consultationCubit!.isLoading;
        audioConsultationModel = consultationCubit!.audioConsultationModel;
        selectedMonth = consultationCubit!.selectedMonth;
        isError = consultationCubit!.isError;

        return Scaffold(
          appBar: CustomAppBar.appBar(context, text: "audio_consultation".tr),
          backgroundColor: Colors.white,
          body: isLoading == true
              ? Center(child: const CircularProgressIndicator())
              : isError == true
                  ? NetFailedWidget(onPress: () {
                      consultationCubit!.emit(AudioConsultationInitialStates());
                      consultationCubit!.getAudioConsultationData(
                          currentMonth.toString(),
                          "60",
                          DateTime.now().day.toString());
                    })
                  : ModalProgressHUD(
                      inAsyncCall: state is LoadingState,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ConsultantDetails(
                                videoConsultationModel: audioConsultationModel,
                              ),
                              SizedBox(
                                height: 15.w,
                              ),
                              // const MonthDropper(),
                              DropdownButtonHideUnderline(
                                child: DropdownButton<Months>(
                                    value: selectedMonth,
                                    iconDisabledColor: mainColor,
                                    iconEnabledColor: mainColor,
                                    items: audioConsultationModel!.data!.months!
                                        .map(
                                            (month) => DropdownMenuItem<Months>(
                                                  child: Text(
                                                    month.value.toString(),
                                                    style: const TextStyle(
                                                        color: mainColor),
                                                  ),
                                                  value: month,
                                                ))
                                        .toList(),
                                    onChanged: (value) {
                                      consultationCubit!
                                          .getVideoConsultationByMonth(
                                              value!.key.toString(),
                                              audioConsultationModel!
                                                  .data!
                                                  .periods![consultationCubit!
                                                      .durationSelectedIndex]
                                                  .key
                                                  .toString(),
                                              value);
                                    }),
                              ),
                              SizedBox(
                                height: 80.h,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: audioConsultationModel!
                                        .data!.days!.length,
                                    itemBuilder: (context, index) {
                                      return DayItem(
                                        borderColor:
                                            consultationCubit!.selectedIndex ==
                                                    index
                                                ? mainColor
                                                : grey,
                                        containerColor:
                                            consultationCubit!.selectedIndex ==
                                                    index
                                                ? mainColor
                                                : Colors.white,
                                        daysColor:
                                            consultationCubit!.selectedIndex ==
                                                    index
                                                ? Colors.white
                                                : grey,
                                        dayKeyColor:
                                            consultationCubit!.selectedIndex ==
                                                    index
                                                ? Colors.white
                                                : Colors.black,
                                        onPress: () {
                                          consultationCubit!
                                              .checkDaySelectedIndex(index);
                                          consultationCubit!.getDataByDay(selectedMonth!.key.toString(),
                                              audioConsultationModel!
                                                  .data!
                                                  .periods![consultationCubit!
                                                  .durationSelectedIndex]
                                                  .key
                                                  .toString(),
                                              audioConsultationModel!.data!.days![index].key ?? "", selectedMonth!);
                                        },
                                        daysKey: audioConsultationModel!
                                            .data!.days![index].key,
                                        daysValue: audioConsultationModel!
                                            .data!.days![index].value,
                                      );
                                    }),
                              ),
                              SizedBox(
                                height: 20.w,
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
                                        color: yelloCollor, fontSize: 15.h),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 60.h,
                                child: ListView.builder(
                                    itemCount: audioConsultationModel!
                                        .data!.times!.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 2.0),
                                        child: TimeItem(
                                            containerColor: consultationCubit!
                                                        .timeSelectedIndex ==
                                                    index
                                                ? mainColor
                                                : Colors.white,
                                            borderColor: consultationCubit!
                                                        .timeSelectedIndex ==
                                                    index
                                                ? mainColor
                                                : lightGrey,
                                            textColor: consultationCubit!
                                                        .timeSelectedIndex ==
                                                    index
                                                ? Colors.white
                                                : grey,
                                            onPress: () {
                                              consultationCubit!
                                                  .checkTimeSelectedIndex(
                                                      index);
                                            },
                                            time: audioConsultationModel!
                                                .data!.times![index].value),
                                      );
                                    }),
                              ),
                              SizedBox(
                                height: 30.w,
                              ),
                              TitleText(title: "consultation_duration".tr),
                              SizedBox(
                                height: 130.h,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: audioConsultationModel!
                                        .data!.periods!.length,
                                    itemBuilder: (context, index) {
                                      return DurationItem(
                                        time: audioConsultationModel!
                                                .data!.periods![index].key
                                                .toString() +
                                            " " +
                                            audioConsultationModel!
                                                .data!.periods![index].typeValue
                                                .toString(),
                                        price: audioConsultationModel!
                                            .data!.periods![index].price,
                                        containerColor: consultationCubit!
                                                    .durationSelectedIndex ==
                                                index
                                            ? mainColor
                                            : Colors.white,
                                        borderColor: consultationCubit!
                                                    .durationSelectedIndex ==
                                                index
                                            ? mainColor
                                            : lightGrey,
                                        textPriceColor: consultationCubit!
                                                    .durationSelectedIndex ==
                                                index
                                            ? Colors.white
                                            : yelloCollor,
                                        textTimeColor: consultationCubit!
                                                    .durationSelectedIndex ==
                                                index
                                            ? Colors.white
                                            : yelloCollor,
                                        iconColor: consultationCubit!
                                                    .durationSelectedIndex ==
                                                index
                                            ? Colors.white
                                            : darkGrey,
                                        onPress: () {
                                          consultationCubit!
                                              .checkDurationSelectedIndex(
                                                  index);
                                          consultationCubit!
                                              .getVideoConsultationByPeriod(
                                                  selectedMonth!.key.toString(),
                                                  audioConsultationModel!
                                                      .data!
                                                      .periods![consultationCubit!
                                                          .durationSelectedIndex]
                                                      .key
                                                      .toString(),
                                                  selectedMonth!, audioConsultationModel!.data!.days![consultationCubit!.selectedIndex].key ?? "");
                                        },
                                      );
                                    }),
                              ),
                              SizedBox(
                                height: 30.w,
                              ),
                              RoundedYellowButton(
                                  text: "reserve_consultation".tr,
                                  onTap: () {
                                    final isLogged =
                                        box.read(Constants.isLogged.toString());
                                    if (isLogged == null || isLogged == false) {
                                      successDialog(
                                        context: context,
                                        buttonTitle: "login".tr,
                                        message: "you_should_login_first".tr,
                                        onTap: () {
                                          Navigator.pop(context);
                                          Get.to(() => LoginScreen(
                                                comeFromHome: true,
                                              ));
                                        },
                                      );
                                    } else {
                                      // Get.to(()=>  AudioConfirmAppointmentScreen(title: "Audio Consultation"));
                                      consultationCubit!.getAudioBookAppointmentData(
                                          consultationCubit!.selectedMonth == null
                                              ? audioConsultationModel!
                                                  .data!
                                                  .months![int.parse(audioConsultationModel!.data!.currentMonthNumber.toString()) -
                                                      1]
                                                  .key
                                                  .toString()
                                              : consultationCubit!
                                                  .selectedMonth!.key
                                                  .toString(),
                                          audioConsultationModel!
                                              .data!
                                              .days![consultationCubit!
                                                  .selectedIndex]
                                              .key
                                              .toString(),
                                          audioConsultationModel!
                                              .data!
                                              .times![consultationCubit!
                                                  .timeSelectedIndex]
                                              .key
                                              .toString(),
                                          audioConsultationModel!
                                              .data!
                                              .periods![consultationCubit!.durationSelectedIndex]
                                              .key
                                              .toString(),
                                          '');
                                    }
                                  }),
                              SizedBox(
                                height: 30.w,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
        );
      }, listener: (context, state) {
        if (state is BookAppointmentSuccessfully) {
          Get.to(() => AudioConfirmAppointmentScreen(
                title: "Audio Consultation",
                bookID: state.bookID,
              ));
        } else if (state is BookAppointmentErrorState) {
          failedDialog(context: context, message: "network_error".tr);
        } else if (state is GetConsultationDataByMonth) {
          // consultationCubit!.checkSelectedMonth(state.month);
          selectedMonth = state.month;
        } else if (state is CheckSelectedMonth) {
          print("<<<<<<<<<<<<<>>>>>>>>>>>>");
          selectedMonth = state.months;
        } else if (state is BookAppointmentFailed) {
          failedDialog(context: context, message: state.message);
        }
      }),
    );
  }
}
