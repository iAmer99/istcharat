import 'package:dio/dio.dart';
import 'package:istchrat/screens/confirm_payment/video/VideoConfirmAppointmentModel.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';

class VideoConfirmAppointmentRepo{
  
  getVideoConfirmAppointmentData(String coupon,String bookID) async {
    try{
      final dio = DioUtilNew.dio;
      final result = await DioUtilNew.get("videoConsultations/confirmAppointment/$bookID",
      );
      return VideoConfirmAppointmentModel.fromJson(result.data);
    }
    catch(e){
      print(e);
    }
  }
}