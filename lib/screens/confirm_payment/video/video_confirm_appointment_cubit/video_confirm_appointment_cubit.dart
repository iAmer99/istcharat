import 'dart:io' show Platform;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:istchrat/main.dart';
import 'package:istchrat/screens/confirm_payment/check_coupon/CheckCouponModel.dart';
import 'package:istchrat/screens/confirm_payment/check_coupon/check_coupon_repo.dart';
import 'package:istchrat/screens/confirm_payment/confirm_reservation_repo/ConfirmReservationModel.dart';
import 'package:istchrat/screens/confirm_payment/confirm_reservation_repo/confirm_reservation_repo.dart';
import 'package:istchrat/screens/confirm_payment/video/VideoConfirmAppointmentModel.dart';
import 'package:istchrat/screens/confirm_payment/video/repo/video_confirm_appointment_repo.dart';
import 'package:istchrat/screens/confirm_payment/video/video_confirm_appointment_cubit/video_confirm_appointment_states.dart';

class VideoConfirmAppointmentCubit
    extends Cubit<VideoConfirmAppointmentStates> {
  VideoConfirmAppointmentCubit() : super(VideoConfirmAppointmentInitialState());

  static VideoConfirmAppointmentCubit get(context) => BlocProvider.of(context);

  VideoConfirmAppointmentModel? videoConfirmAppointmentModel;
  VideoConfirmAppointmentRepo videoConfirmAppointmentRepo =
      VideoConfirmAppointmentRepo();
  ConfirmReservationRepo confirmReservationRepo = ConfirmReservationRepo();
  ConfirmReservationModel? confirmReservationModel;
  bool isLoading = false;
  bool isError = false;
  CheckCouponModel? checkCouponModel;
  CheckCouponRepo checkCouponRepo = CheckCouponRepo();

  getVideoConfirmAppointmentData(String bookID) async {
    try {
      isLoading = true;
      isError = false;
      videoConfirmAppointmentModel = await videoConfirmAppointmentRepo
          .getVideoConfirmAppointmentData("", bookID);
      print(videoConfirmAppointmentModel!.data!.lecturer!.name!);
      isLoading = false;
      emit(GetVideoConfirmAppointmentData());
    } catch (e) {
      print(e);
      isLoading = false;
      isError = true;
      emit(VideoConfirmAppointmentError());
    }
  }

  confirmReservation(String consultationType, String bookID, String coupon,
      String paymentMethod, num price) async {
    try {
      emit(LoadingState());
      confirmReservationModel = await confirmReservationRepo.confirmReservation(
          consultationType, bookID, coupon, paymentMethod);
      print(confirmReservationModel!.data!.message);
      if(confirmReservationModel?.statusCode == 200 && price == 0){
        emit(BookedSuccessfully(
            confirmReservationModel!.data!.message.toString()));
      }else{
        if(paymentMethod == "wallet"){
          if(confirmReservationModel?.statusCode != 200){
            emit(ConfirmReservationFailed(
                confirmReservationModel!.data!.message.toString()));
          }else{
            emit(WalletConfirmReservationSuccess(
              confirmReservationModel!.data!.message.toString(),));
          }
        }else{
          if (confirmReservationModel!.data!.paymentUrl == null ||
              confirmReservationModel!.data!.paymentUrl!.isEmpty ||
              confirmReservationModel?.statusCode != 200) {
            emit(ConfirmReservationFailed(
                confirmReservationModel!.data!.message.toString()));
          } else {
            emit(ConfirmReservationSuccess(
                confirmReservationModel!.data!.message.toString(),
                confirmReservationModel!.data!.paymentUrl.toString()));
          }
        }
      }
    } catch (e) {
      print(e.toString());
      emit(ConfirmReservationError());
    }
  }

  checkCoupon(String consultationType, String coupon, String id) async {
    try {
      emit(LoadingState());
      final response =
          await checkCouponRepo.checkCoupon(consultationType, coupon, id);
      response.fold((error) {
        emit(CheckCouponError(error.data?.message ?? "unknown_error".tr));
      }, (data) {
        checkCouponModel = data;
        print(checkCouponModel!.data!.message);
        emit(CheckCouponSuccess(checkCouponModel!.data!.message.toString()));
      });
    } catch (e) {
      print(e.toString());
      emit(ConfirmReservationError());
    }
  }

  changeMethod(String newMethod) => paymentMethod = newMethod;
  String paymentMethod =
      box.read('isUploading') && Platform.isIOS ? "iap" : "knet";
}
