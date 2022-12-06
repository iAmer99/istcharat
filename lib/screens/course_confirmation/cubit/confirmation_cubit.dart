import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:istchrat/screens/confirm_payment/check_coupon/CheckCouponModel.dart';
import 'package:istchrat/screens/course_confirmation/cubit/confirmation_states.dart';
import 'package:istchrat/screens/course_confirmation/repo/confirmation_repositoy.dart';
import 'package:istchrat/screens/course_confirmation/repo/models/book_details_reponse.dart';
import 'package:istchrat/screens/course_confirmation/repo/models/course_details_response.dart';

import '../../../main.dart';
import '../../confirm_payment/check_coupon/check_coupon_repo.dart';


class ConfirmationCubit extends Cubit<ConfirmationStates> {
  ConfirmationCubit() : super(ConfirmationInitialState());
  static ConfirmationCubit get(BuildContext context) => BlocProvider.of(context);


  final ConfirmationRepository _repository = ConfirmationRepository();
  final CheckCouponRepo checkCouponRepo = CheckCouponRepo();
  late BookDetailsReponse bookDetails;
  late CourseDetailsResponse courseDetails;
  CheckCouponModel? couponModel;
  bool isBook = false;
  String paymentMethod = box.read('isUploading') && Platform.isIOS ? "iap" : "knet";

  Future getDetails({required String id, required String type}) async{
    isBook = type == "books";
    emit(ConfirmationDetailsLoadingState());
    if(type == "books"){
      final response = await _repository.getBookDetails(id: id);
      response.fold((error){
        emit(ConfirmationDataErrorState(error));
      }, (data){
        bookDetails = data;
        emit(ConfirmationDataSuccessState());
      });
    }else{
      final response = await _repository.getCourseDetails(id: id, urlSegment: type);
      response.fold((error){
        emit(ConfirmationDataErrorState(error));
      }, (data){
        courseDetails = data;
        emit(ConfirmationDataSuccessState());
      });
    }
  }

  Future confirmBuying({required String id, required String type, required String coupon}) async{
    emit(ConfirmLoadingState());
    final response = await _repository.confirmPayment(id: id, type: type, method: paymentMethod, coupon: coupon);
    response.fold((error){
      emit(ConfirmErrorState(error));
    }, (data){
      if(paymentMethod == "wallet"){
        emit(WalletConfirmSuccessState(msg: data.data?.message ?? ""));
      }else{
        emit(ConfirmSuccessState(msg: data.data?.message ?? "", url: data.data?.paymentLink ?? ""));
      }
    });
  }

   changeMethod(String newMethod) => paymentMethod = newMethod;

  checkCoupon(String consultationType,String coupon, String id) async {
    try{
      emit(ConfirmLoadingState());
      final response = await checkCouponRepo.checkCoupon(consultationType, coupon, id);
      response.fold((error){
        emit(CheckCouponError(error.data?.message ?? "unknown_error".tr ));
      }, (data){
        couponModel = data;
        emit(CheckCouponSuccess(data.data?.message ?? "done".tr));
      });
    }
    catch(e){
      emit(CheckCouponError("unknown_error".tr ));
    }
  }
}