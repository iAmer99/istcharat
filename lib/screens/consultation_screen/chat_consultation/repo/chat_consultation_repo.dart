import 'package:dio/dio.dart';
import 'package:istchrat/screens/consultation_screen/chat_consultation/repo/ChatBookAppointmentModel.dart';
import 'package:istchrat/screens/consultation_screen/chat_consultation/repo/ChatConsultationModel.dart';

import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';

class ChatConsultationRepo{

  getChatConsultationData(
      {required String month,
      required String period,
      required String consultationType,
      String? day}) async {
    try{
      final dio = DioUtilNew.dio;
      final result = await DioUtilNew.get("$consultationType/availableAppointments",
          queryParameters: {
            "month" : month,
            "period": period,
             "day" : day ?? DateTime.now().day,
          });
      return ChatConsultationModel.fromJson(result.data);
    }
    catch(e){
      print(e);
    }
  }
  getChatBookAppointmentData(String monthKey,String dayKey,String timeKey,String periodKey,String coupon,String consultationType) async {
    try{
      final dio = DioUtilNew.dio;
      final result = await DioUtilNew.post("$consultationType/bookAppointment",
          data: {
            "month_key": monthKey,
            "day_key": dayKey,
            "time_key": timeKey,
            "period_key": periodKey,
            "coupon": coupon
          },
          // options: Options(
          //     headers: {
          //       'Authorization': "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYXBpLWlzdGNocmF0Lm1hemFkYWsubmV0XC9hcGlcL3YxXC9hdXRoXC9sb2dpbiIsImlhdCI6MTY0NjkwNTE0NiwiZXhwIjoxNjUwNTA1MTQ2LCJuYmYiOjE2NDY5MDUxNDYsImp0aSI6InpHUm5mNzVPYUdIaG9rd2wiLCJzdWIiOjMsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.JNbMo91I1l9NeKQliAeec51yZqeNtCl6KeKkJ25WHqo"
          //
          //     }
          // )
      );
      return ChatBookAppointmentModel.fromJson(result.data);
    }
    catch(e){
      print(e);
    }
  }

}