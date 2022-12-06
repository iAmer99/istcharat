import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:istchrat/custom_widgets/custom_dialogs/failed_dialog/failed_dialog.dart';
import 'package:istchrat/screens/confirm_payment/widgets/confirmation_details.dart';
import 'package:istchrat/screens/confirm_payment/widgets/cost_details.dart';
import 'package:istchrat/screens/confirm_payment/widgets/coupon_form_field.dart';
import 'package:istchrat/screens/confirm_payment/widgets/coupon_offer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:istchrat/screens/confirm_payment/widgets/payment_method.dart';
import 'package:istchrat/screens/confirm_payment/widgets/success_dialog_content.dart';
import 'package:istchrat/screens/consultation_screen/widgets/title_text.dart';
import 'package:istchrat/screens/course_confirmation/cubit/confirmation_cubit.dart';
import 'package:istchrat/screens/course_confirmation/cubit/confirmation_states.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:istchrat/shared_components/helper_functions.dart';
import 'package:istchrat/shared_components/widgets/rounded_yellow_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../custom_widgets/custom_dialogs/success_dialog/custom_success_dialog.dart';
import '../../main.dart';
import '../../shared_components/widgets/custom_app_bar.dart';
import '../bottom_nav_bar/bottom_nav_bar_screen.dart';
import '../in_app_purchase_screen/inAppPurchase_screen.dart';
import '../payment_screen/webview_payment_screen.dart';

class PaymentConfirmation extends StatelessWidget {
  final String title;
  final String id;
  final String itemId;
  final String type;
  TextEditingController couponController = TextEditingController();

  PaymentConfirmation(
      {Key? key,
      required this.title,
      required this.id,
      required this.type,
      required this.itemId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConfirmationCubit>(
      create: (context) => ConfirmationCubit()..getDetails(id: id, type: type),
      child: BlocConsumer<ConfirmationCubit, ConfirmationStates>(
        builder: (context, state) {
          final ConfirmationCubit cubit = ConfirmationCubit.get(context);
          return Scaffold(
            appBar: CustomAppBar.appBar(context, text: title),
            backgroundColor: Colors.white,
            body: state is ConfirmationDetailsLoadingState
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : state is ConfirmationDataErrorState
                    ? Center(
                        child: Text(
                          state.error,
                          style: TextStyle(color: mainColor, fontSize: 15.sp),
                        ),
                      )
                    : ModalProgressHUD(
                        inAsyncCall: state is ConfirmLoadingState,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                               /* if (!(box.read('isUploading') &&
                                    Platform.isIOS))
                                  const CouponOffer(),*/
                                SizedBox(
                                  height: 15.h,
                                ),
                                ConfirmationDetails(
                                  name: cubit.isBook
                                      ? cubit.bookDetails.row?.book?.title ?? ""
                                      : cubit.courseDetails.row?.course
                                              ?.title ??
                                          "",
                                  image: cubit.isBook
                                      ? cubit.bookDetails.row?.book?.image ?? ""
                                      : cubit.courseDetails.row?.course
                                              ?.image ??
                                          "",
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                if (!(box.read('isUploading') &&
                                    Platform.isIOS))
                                  CouponFormField(
                                    controller: couponController,
                                    onTap: () {
                                      cubit.checkCoupon(type, couponController.text, itemId);
                                    },
                                  ),
                                if (!(box.read('isUploading') &&
                                    Platform.isIOS))
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                TitleText(title: "payment_method".tr),
                                PaymentMethod(
                                  onMethodChange: (String value) =>
                                      cubit.changeMethod(value),
                                  value: cubit.paymentMethod,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                CostDetails(
                                  discount: cubit.couponModel?.data?.discount,
                                  consultationFees: cubit.isBook
                                      ? cubit.bookDetails.row?.bookPrice ?? ""
                                      : cubit.courseDetails.row?.coursePrice ??
                                          "",
                                  feesText: cubit.isBook
                                      ? "book_fees".tr
                                      : "course_fees".tr,
                                  tax: cubit.isBook
                                      ? cubit.bookDetails.row?.taxFee ?? ""
                                      : cubit.courseDetails.row?.taxFee ?? "",
                                  total: cubit.couponModel?.data?.priceAfterDiscount ?? ( cubit.isBook
                                      ? cubit.bookDetails.row?.totalGrand ?? ""
                                      : cubit.courseDetails.row?.totalGrand ??
                                          ""),
                                  currency: cubit.isBook
                                      ? cubit.bookDetails.row?.currency ?? ""
                                      : cubit.courseDetails.row?.currency ?? "",
                                ),
                                SizedBox(
                                  height: 30.w,
                                ),
                                RoundedYellowButton(
                                    text: "confirm_reservation".tr,
                                    onTap: () {
                                      if (cubit.paymentMethod == "iap") {
                                        Get.to(() => InAppPurchaseScreen(
                                              title: title,
                                              type: getIAPType(type),
                                              id: itemId,
                                            ));
                                      } else {
                                        cubit.confirmBuying(id: id, type: type, coupon: couponController.text);
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
        listener: (context, state) async {
          if (state is ConfirmSuccessState) {
            if (state.url.isNotEmpty) {
              Get.to(()=> WebViewPaymentScreen(paymentURL: state.url, type: type,));
            } else {
              Get.defaultDialog(
                title: "",
                content: SuccessDialogContent(
                  message: state.msg,
                ),
              );
            }
          } else if (state is ConfirmErrorState) {
            failedDialog(
              context: context,
              message: state.error,
            );
          }else if (state is CheckCouponSuccess) {
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
          }else if(state is WalletConfirmSuccessState){
            Get.defaultDialog(
              title: "",
              content: CustomSuccessDialog(
                message: state.msg,
                onTap: (){
                  Get.offAll(BottomNavBarScreen(openMyLibrary: true, index: getCategoryIndex(type),),);
                },
              ),
            );
          }
        },
      ),
    );
  }
}
