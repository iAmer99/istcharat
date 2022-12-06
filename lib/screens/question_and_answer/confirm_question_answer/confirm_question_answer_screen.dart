import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:istchrat/custom_widgets/custom_dialogs/success_dialog/custom_success_dialog.dart';
import 'package:istchrat/screens/confirm_payment/confirm_reservation_repo/ConfirmReservationModel.dart';
import 'package:istchrat/screens/confirm_payment/widgets/cost_details.dart';
import 'package:istchrat/screens/confirm_payment/widgets/coupon_form_field.dart';
import 'package:istchrat/screens/confirm_payment/widgets/coupon_offer.dart';
import 'package:istchrat/screens/confirm_payment/widgets/payment_method.dart';
import 'package:istchrat/screens/consultation_screen/widgets/title_text.dart';
import 'package:istchrat/screens/question_and_answer/confirm_question_answer/cubit/confirm_question_answer_cubit.dart';
import 'package:istchrat/screens/question_and_answer/confirm_question_answer/cubit/confirm_question_answer_states.dart';
import 'package:istchrat/screens/question_and_answer/confirm_question_answer/repo/ConfirmQuestionAnswerModel.dart';
import 'package:istchrat/screens/question_and_answer/confirm_question_answer/widgets/question_answer_confirmation_details.dart';
import 'package:istchrat/shared_components/widgets/custom_app_bar.dart';
import 'package:istchrat/shared_components/widgets/rounded_yellow_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../custom_widgets/custom_dialogs/failed_dialog/failed_dialog.dart';
import '../../../main.dart';
import '../../../shared_components/helper_functions.dart';
import '../../bottom_nav_bar/bottom_nav_bar_screen.dart';
import '../../payment_screen/webview_payment_screen.dart';

class ConfirmQuestionAnswerScreen extends StatelessWidget {
  ConfirmQuestionAnswerScreen(
      {Key? key, required this.title, this.bookID, this.consultationType})
      : super(key: key);
  final String title;
  final String? bookID;
  final String? consultationType;
  ConfirmQuestionAnswerCubit? cubit;
  ConfirmQuestionAnswerModel? confirmQuestionAnswerModel;
  ConfirmReservationModel? confirmReservationModel;
  TextEditingController couponController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConfirmQuestionAnswerCubit()
        ..getQuestionAnswerConfirmData(
            bookID.toString(), consultationType.toString()),
      child:
          BlocConsumer<ConfirmQuestionAnswerCubit, ConfirmQuestionAnswerStates>(
              builder: (context, state) {
        cubit = ConfirmQuestionAnswerCubit.get(context);
        confirmQuestionAnswerModel = cubit!.confirmQuestionAnswerModel;
        confirmReservationModel = cubit!.confirmReservationModel;
        isLoading = cubit!.isLoading;
        return Scaffold(
          appBar: CustomAppBar.appBar(context, text: title),
          backgroundColor: Colors.white,
          body: isLoading == true
              ? Center(child: CircularProgressIndicator())
              : ModalProgressHUD(
                  inAsyncCall: state is LoadingState,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /* if (!(box.read('isUploading') && Platform.isIOS))
                            const CouponOffer(),*/
                          SizedBox(
                            height: 15.h,
                          ),
                          QuestionAnswerConfirmationDetails(
                            name: confirmQuestionAnswerModel!
                                .data!.lecturer!.name,
                            position: confirmQuestionAnswerModel!
                                .data!.lecturer!.position,
                            image: confirmQuestionAnswerModel
                                ?.data?.lecturer?.image,
                            university: confirmQuestionAnswerModel!
                                .data!.lecturer!.university,
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          if (!(box.read('isUploading') && Platform.isIOS))
                            CouponFormField(
                              controller: couponController,
                              onTap: () {
                                cubit!.checkCoupon(consultationType.toString(),
                                    couponController.text, bookID ?? "");
                              },
                            ),
                          if (!(box.read('isUploading') && Platform.isIOS))
                            SizedBox(
                              height: 20.h,
                            ),
                          TitleText(title: "payment_method".tr),
                          PaymentMethod(
                            onMethodChange: (String value) =>
                                cubit!.changeMethod(value),
                            value: cubit!.paymentMethod,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          CostDetails(
                            communicationMethod: confirmQuestionAnswerModel!
                                .data!.results!.consultationType,
                            consultationFees: confirmQuestionAnswerModel!
                                .data!.results!.consultationFee,
                            tax: confirmQuestionAnswerModel!
                                .data!.results!.taxFee,
                            total: cubit?.checkCouponModel?.data?.priceAfterDiscount ?? confirmQuestionAnswerModel!
                                .data!.results!.totalGrand,
                            currency: confirmQuestionAnswerModel!
                                .data!.results!.currency,
                            discount: cubit?.checkCouponModel?.data?.discount,
                          ),
                          SizedBox(
                            height: 30.w,
                          ),
                          RoundedYellowButton(
                              text: "confirm_reservation".tr,
                              onTap: () {
                                cubit!.confirmReservation(
                                    consultationType.toString(),
                                    bookID.toString(),
                                    couponController.text,
                                    cubit!.paymentMethod,
                                    double.tryParse(confirmQuestionAnswerModel
                                                ?.data?.results?.totalGrand ??
                                            "0") ??
                                        0);
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
          Get.to(() => WebViewPaymentScreen(
                paymentURL: state.url,
                type: consultationType ?? "",
              ));
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
                Get.offAll(
                  BottomNavBarScreen(
                    openMyLibrary: true,
                    index: getCategoryIndex(consultationType ?? ""),
                  ),
                );
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
                  index: getCategoryIndex(consultationType ?? ""),),);
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
