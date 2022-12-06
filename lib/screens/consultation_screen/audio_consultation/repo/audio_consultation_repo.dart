import 'package:dio/dio.dart';
import 'package:istchrat/screens/consultation_screen/audio_consultation/repo/AudioBookAppointmentModel.dart';
import 'package:istchrat/screens/consultation_screen/audio_consultation/repo/AudioConsultationModel.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';

class AudioConsultationRepo{

  getAudioConsultationData({required String month, required String period, String? day}) async {
    try{
      final dio = DioUtilNew.dio;
      final result = await DioUtilNew.get("voiceConsultations/availableAppointments",
      queryParameters: {
        "month" : month,
        "period": period,
        "day" : day ?? DateTime.now().day,
      });
      print(result.data);
      return AudioConsultationModel.fromJson(result.data);
    }
    catch(e){
      print(e);
    }
  }
  getAudioBookAppointmentData(String monthKey,String dayKey,String timeKey,String periodKey,String coupon) async {
    try{
      final dio = DioUtilNew.dio;
      final result = await DioUtilNew.post("voiceConsultations/bookAppointment",
          data: {
            "month_key": monthKey,
            "day_key": dayKey,
            "time_key": timeKey,
            "period_key": periodKey,
            "coupon": coupon
          },
      );
      return AudioBookAppointmentModel.fromJson(result.data);
    }
    catch(e){
      print(e);
    }
  }

}