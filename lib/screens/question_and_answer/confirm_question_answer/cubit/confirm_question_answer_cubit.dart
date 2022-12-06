import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:istchrat/screens/confirm_payment/check_coupon/CheckCouponModel.dart';
import 'package:istchrat/screens/confirm_payment/check_coupon/check_coupon_repo.dart';
import 'package:istchrat/screens/confirm_payment/confirm_reservation_repo/ConfirmReservationModel.dart';
import 'package:istchrat/screens/confirm_payment/confirm_reservation_repo/confirm_reservation_repo.dart';
import 'package:istchrat/screens/question_and_answer/confirm_question_answer/cubit/confirm_question_answer_states.dart';
import 'package:istchrat/screens/question_and_answer/confirm_question_answer/repo/ConfirmQuestionAnswerModel.dart';
import 'package:istchrat/screens/question_and_answer/confirm_question_answer/repo/confirm_question_answer_repo.dart';

class ConfirmQuestionAnswerCubit extends Cubit<ConfirmQuestionAnswerStates> {
  ConfirmQuestionAnswerCubit() : super(ConfirmQuestionAnswerInitialState());

  static ConfirmQuestionAnswerCubit get(context) => BlocProvider.of(context);

  ConfirmQuestionAnswerModel? confirmQuestionAnswerModel;
  ConfirmQuestionAnswerRepo confirmQuestionAnswerRepo =
      ConfirmQuestionAnswerRepo();
  ConfirmReservationRepo confirmReservationRepo = ConfirmReservationRepo();
  ConfirmReservationModel? confirmReservationModel;
  bool isLoading = false;
  CheckCouponModel? checkCouponModel;
  CheckCouponRepo checkCouponRepo = CheckCouponRepo();

  getQuestionAnswerConfirmData(String bookID, String consultationType) async {
    try {
      isLoading = true;
      confirmQuestionAnswerModel = await confirmQuestionAnswerRepo
          .getQuestionAnswerConfirmData("", bookID, consultationType);
      print(confirmQuestionAnswerModel!.data!.lecturer!.name!);
      isLoading = false;
      emit(GetQuestionConfirmAppointmentData());
    } catch (e) {
      print(e);
      isLoading = false;
      emit(QuestionConfirmAppointmentError());
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
  String paymentMethod = "knet";
}
