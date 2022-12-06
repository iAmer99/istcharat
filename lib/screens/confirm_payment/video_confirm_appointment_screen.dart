import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:istchrat/custom_widgets/custom_dialogs/success_dialog/custom_success_dialog.dart';
import 'package:istchrat/custom_widgets/net_failed_widget.dart';
import 'package:istchrat/screens/confirm_payment/confirm_reservation_repo/ConfirmReservationModel.dart';
import 'package:istchrat/screens/confirm_payment/video/VideoConfirmAppointmentModel.dart';
import 'package:istchrat/screens/confirm_payment/video/video_confirm_appointment_cubit/video_confirm_appointment_cubit.dart';
import 'package:istchrat/screens/confirm_payment/video/video_confirm_appointment_cubit/video_confirm_appointment_states.dart';
import 'package:istchrat/screens/confirm_payment/widgets/success_dialog_content.dart';
import 'package:istchrat/screens/consultation_screen/widgets/title_text.dart';
import 'package:istchrat/screens/payment_screen/webview_payment_screen.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:istchrat/shared_components/helper_functions.dart';
import 'package:istchrat/shared_components/widgets/custom_app_bar.dart';
import 'package:istchrat/shared_components/widgets/rounded_yellow_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../custom_widgets/custom_dialogs/failed_dialog/failed_dialog.dart';
import '../../main.dart';
import '../bottom_nav_bar/bottom_nav_bar_screen.dart';
import '../in_app_purchase_screen/inAppPurchase_screen.dart';
import 'widgets/confirmation_details.dart';
import 'widgets/cost_details.dart';
import 'widgets/coupon_form_field.dart';
import 'widgets/coupon_offer.dart';
import 'widgets/payment_method.dart';

class VideoConfirmAppointmentScreen extends StatelessWidget {
  VideoConfirmAppointmentScreen({Key? key, required this.title, this.bookID})
      : super(key: key);
  final String title;
  final String? bookID;
  VideoConfirmAppointmentCubit? videoConfirmAppCubit;
  VideoConfirmAppointmentModel? videoConfirmAppModel;
  ConfirmReservationModel? confirmReservationModel;
  TextEditingController couponController = TextEditingController();
  bool isLoading = false;
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      VideoConfirmAppointmentCubit()
        ..getVideoConfirmAppointmentData(bookID.toString()),
      child: BlocConsumer<VideoConfirmAppointmentCubit,
          VideoConfirmAppointmentStates>(
        listener: (context, state) {
          if (state is ConfirmReservationSuccess) {
            Get.to(() =>
                WebViewPaymentScreen(
                  paymentURL: state.url, type: "video_consultations",));
          } else if (state is ConfirmReservationFailed) {
            failedDialog(
              context: context,
              message: state.message,
            );
          } else if (state is CheckCouponSuccess) {
            Get.defaultDialog(
              title: "",
              content: CustomSuccessDialog(
                message: state.message,
              ),
            );
          } else if (state is CheckCouponError) {
            failedDialog(
              context: context,
              message: state.message,
            );
          } else if (state is WalletConfirmReservationSuccess) {
            Get.defaultDialog(
              title: "",
              content: CustomSuccessDialog(
                message: state.message,
                onTap: () {
                  Get.offAll(BottomNavBarScreen(openMyLibrary: true,
                    index: getCategoryIndex("video_consultations"),),);
                },
              ),
            );
          }else if(state is BookedSuccessfully){
            Get.defaultDialog(
              title: "",
              content: CustomSuccessDialog(
                message: state.message,
                onTap: () {
                  Get.offAll(BottomNavBarScreen(openMyLibrary: true,
                    index: getCategoryIndex("video_consultations"),),);
                },
              ),
            );
          }
        },
        builder: (context, state) {
          videoConfirmAppCubit = VideoConfirmAppointmentCubit.get(context);
          videoConfirmAppModel =
              videoConfirmAppCubit!.videoConfirmAppointmentModel;
          confirmReservationModel =
              videoConfirmAppCubit!.confirmReservationModel;
          isLoading = videoConfirmAppCubit!.isLoading;
          isError = videoConfirmAppCubit!.isError;
          return Scaffold(
            appBar: CustomAppBar.appBar(context, text: title),
            backgroundColor: Colors.white,
            body: isLoading == true
                ? Center(child: CircularProgressIndicator())
                : isError == true
                ? NetFailedWidget(onPress: () {
              videoConfirmAppCubit!
                  .emit(VideoConfirmAppointmentInitialState());
              videoConfirmAppCubit!
                  .getVideoConfirmAppointmentData(bookID.toString());
            })
                : ModalProgressHUD(
              inAsyncCall: state is LoadingState,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     /* if(!(box.read('isUploading') &&
                          Platform.isIOS)) const CouponOffer(),*/
                      SizedBox(
                        height: 15.h,
                      ),
                      ConfirmationDetails(
                        name: videoConfirmAppModel!
                            .data!.lecturer!.name,
                        position: videoConfirmAppModel!
                            .data!.lecturer!.position,
                        university: videoConfirmAppModel!
                            .data!.lecturer!.university,
                        date: videoConfirmAppModel!
                            .data!.appointment!.date,
                        image: videoConfirmAppModel
                            ?.data?.lecturer?.image,
                        time: videoConfirmAppModel!
                            .data!.appointment!.time,
                        period: videoConfirmAppModel!
                            .data!.appointment!.period,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      if(!(box.read('isUploading') &&
                          Platform.isIOS)) CouponFormField(
                        controller: couponController,
                        onTap: () {
                          videoConfirmAppCubit!.checkCoupon(
                              "videoConsultations",
                              couponController.text, bookID ?? "");
                        },
                      ),
                      if(!(box.read('isUploading') && Platform.isIOS)) SizedBox(
                        height: 20.h,
                      ),
                      TitleText(title: "payment_method".tr),
                      PaymentMethod(
                        onMethodChange: (String value) =>
                            videoConfirmAppCubit!.changeMethod(value),
                        value: videoConfirmAppCubit!.paymentMethod,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CostDetails(
                        communicationMethod: videoConfirmAppModel!
                            .data!.results!.consultationType,
                        consultationFees: videoConfirmAppModel!
                            .data!.results!.consultationFee,
                        tax: videoConfirmAppModel!
                            .data!.results!.taxFee,
                        total: videoConfirmAppCubit?.checkCouponModel?.data?.priceAfterDiscount ??  videoConfirmAppModel!
                            .data!.results!.totalGrand,
                        currency: videoConfirmAppModel!
                            .data!.results!.currency,
                        discount: videoConfirmAppCubit?.checkCouponModel?.data?.discount,
                      ),
                      SizedBox(
                        height: 30.w,
                      ),
                      RoundedYellowButton(
                          text: "confirm_reservation".tr,
                          onTap: () {
                            if (videoConfirmAppCubit!.paymentMethod == "iap") {
                              Get.to(() =>
                                  InAppPurchaseScreen(
                                    title: "video_consultation".tr,
                                    type: getIAPType(''),
                                    id: '',));
                            } else {
                              videoConfirmAppCubit!.confirmReservation(
                                  "videoConsultations",
                                  bookID.toString(),
                                  couponController.text,
                                  videoConfirmAppCubit!.paymentMethod,
                                  double.tryParse(videoConfirmAppModel?.data?.results?.totalGrand ?? "0") ?? 0);
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
        },
      ),
    );
  }
}

void _launchURL(String _url) async {
  if (!await launch(_url)) throw 'Could not launch $_url';
}
