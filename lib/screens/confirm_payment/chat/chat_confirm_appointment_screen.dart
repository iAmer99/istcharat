import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:istchrat/custom_widgets/custom_dialogs/success_dialog/custom_success_dialog.dart';
import 'package:istchrat/custom_widgets/net_failed_widget.dart';
import 'package:istchrat/screens/confirm_payment/audio/audio_confirm_appointment_cubit/audio_confirm_appointment_cubit.dart';
import 'package:istchrat/screens/confirm_payment/audio/repo/AudioConfirmPaymentModel.dart';
import 'package:istchrat/screens/confirm_payment/chat/chat_confirm_appointment_cubit/chat_confirm_appointment_cubit.dart';
import 'package:istchrat/screens/confirm_payment/chat/chat_confirm_appointment_cubit/chat_confirm_appointment_states.dart';
import 'package:istchrat/screens/confirm_payment/chat/repo/ChatConfirmAppoitnmentModel.dart';
import 'package:istchrat/screens/confirm_payment/widgets/confirmation_details.dart';
import 'package:istchrat/screens/confirm_payment/widgets/cost_details.dart';
import 'package:istchrat/screens/confirm_payment/widgets/coupon_form_field.dart';
import 'package:istchrat/screens/confirm_payment/widgets/coupon_offer.dart';
import 'package:istchrat/screens/confirm_payment/widgets/payment_method.dart';
import 'package:istchrat/screens/confirm_payment/widgets/success_dialog_content.dart';
import 'package:istchrat/screens/consultation_screen/widgets/title_text.dart';
import 'package:istchrat/shared_components/widgets/custom_app_bar.dart';
import 'package:istchrat/shared_components/widgets/rounded_yellow_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../custom_widgets/custom_dialogs/failed_dialog/failed_dialog.dart';
import '../../../main.dart';
import '../../../shared_components/helper_functions.dart';
import '../../bottom_nav_bar/bottom_nav_bar_screen.dart';
import '../../in_app_purchase_screen/inAppPurchase_screen.dart';
import '../../payment_screen/webview_payment_screen.dart';

class ChatConfirmAppointmentScreen extends StatelessWidget {
  ChatConfirmAppointmentScreen(
      {Key? key,
      required this.title,
      this.bookID,
      required this.consultationType})
      : super(key: key);
  final String title;
  final String? bookID;
  final String consultationType;
  ChatConfirmAppointmentCubit? chatConfirmAppCubit;
  ChatConfirmAppoitnmentModel? chatConfirmAppModel;
  bool isLoading = false;
  bool isError = false;
  TextEditingController couponController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatConfirmAppointmentCubit()
        ..getVideoConfirmAppointmentData(bookID.toString(), consultationType),
      child: BlocConsumer<ChatConfirmAppointmentCubit,
          ChatConfirmAppointmentStates>(builder: (context, state) {
        chatConfirmAppCubit = ChatConfirmAppointmentCubit.get(context);
        chatConfirmAppModel = chatConfirmAppCubit!.chatConfirmAppointmentModel;
        isLoading = chatConfirmAppCubit!.isLoading;
        isError = chatConfirmAppCubit!.isError;
        return Scaffold(
          appBar: CustomAppBar.appBar(context, text: title),
          backgroundColor: Colors.white,
          body: isLoading == true
              ? Center(child: CircularProgressIndicator())
              : isError == true
                  ? NetFailedWidget(onPress: () {
                      chatConfirmAppCubit!
                          .emit(ChatConfirmAppointmentInitialState());
                      chatConfirmAppCubit!.getVideoConfirmAppointmentData(
                          bookID.toString(), consultationType);
                    })
                  : ModalProgressHUD(
                      inAsyncCall: state is LoadingState,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /*if(!(box.read('isUploading') && Platform.isIOS)) const CouponOffer(),*/
                              SizedBox(
                                height: 15.h,
                              ),
                              ConfirmationDetails(
                                name: chatConfirmAppModel!.data!.lecturer!.name,
                                position: chatConfirmAppModel!
                                    .data!.lecturer!.position,
                                university: chatConfirmAppModel!
                                    .data!.lecturer!.university,
                                image:
                                    chatConfirmAppModel?.data?.lecturer?.image,
                                date: chatConfirmAppModel!
                                    .data!.appointment!.date,
                                time: chatConfirmAppModel!
                                    .data!.appointment!.time,
                                period: chatConfirmAppModel!
                                    .data!.appointment!.period,
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              if(!(box.read('isUploading') && Platform.isIOS)) CouponFormField(
                                controller: couponController,
                                onTap: () {
                                  chatConfirmAppCubit!.checkCoupon(
                                      consultationType, couponController.text, bookID ?? "");
                                },
                              ),
                              if(!(box.read('isUploading') && Platform.isIOS)) SizedBox(
                                height: 20.h,
                              ),
                              TitleText(title: "payment_method".tr),
                              PaymentMethod(
                                onMethodChange: (String value) =>
                                    chatConfirmAppCubit!.changeMethod(value),
                                value: chatConfirmAppCubit!.paymentMethod,
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              CostDetails(
                                communicationMethod: chatConfirmAppModel!
                                    .data!.results!.consultationType,
                                consultationFees: chatConfirmAppModel!
                                    .data!.results!.consultationFee,
                                tax: chatConfirmAppModel!.data!.results!.taxFee,
                                total: chatConfirmAppCubit?.checkCouponModel?.data?.priceAfterDiscount ?? chatConfirmAppModel!
                                    .data!.results!.totalGrand,
                                currency: chatConfirmAppModel!
                                    .data!.results!.currency,
                                discount: chatConfirmAppCubit?.checkCouponModel?.data?.discount,
                              ),
                              SizedBox(
                                height: 30.w,
                              ),
                              RoundedYellowButton(
                                  text: "confirm_reservation".tr,
                                  onTap: () {
                                    if(chatConfirmAppCubit!.paymentMethod == "iap"){
                                      Get.to(()=> InAppPurchaseScreen(title: title, id: '', type: getIAPType(''),));
                                    }else{
                                      chatConfirmAppCubit!.confirmReservation(
                                          consultationType,
                                          bookID.toString(),
                                          couponController.text,
                                          chatConfirmAppCubit!.paymentMethod, double.tryParse(chatConfirmAppModel?.data?.results?.totalGrand ?? "0") ?? 0);
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
        if (state is ConfirmReservationSuccess) {
          Get.to(()=> WebViewPaymentScreen(paymentURL: state.url, type: consultationType,));
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
        }else if(state is CheckCouponError){
          failedDialog(
            context: context,
            message: state.message,
          );
        }else if(state is WalletConfirmReservationSuccess){
          Get.defaultDialog(
            title: "",
            content: CustomSuccessDialog(
              message: state.message,
              onTap: (){
                Get.offAll(BottomNavBarScreen(openMyLibrary: true, index: getCategoryIndex(consultationType),),);
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
                  index: getCategoryIndex(consultationType),),);
              },
            ),
          );
        }
      }),
    );
  }

  void _launchURL(String _url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }
}
