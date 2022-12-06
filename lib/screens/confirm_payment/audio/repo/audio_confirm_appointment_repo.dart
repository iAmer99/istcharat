import 'package:dio/dio.dart';
import 'package:istchrat/screens/confirm_payment/audio/repo/AudioConfirmPaymentModel.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';

class AudioConfirmAppointmentRepo{

  getAudioConfirmAppointmentData(String coupon,String bookID) async {
    try{
      final dio = DioUtilNew.dio;
      final result = await DioUtilNew.get("voiceConsultations/confirmAppointment/$bookID",
          // options: Options(
          //     headers: {
          //       'Authorization': "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYXBpLWlzdGNocmF0Lm1hemFkYWsubmV0XC9hcGlcL3YxXC9hdXRoXC9sb2dpbiIsImlhdCI6MTY0NjkwNTE0NiwiZXhwIjoxNjUwNTA1MTQ2LCJuYmYiOjE2NDY5MDUxNDYsImp0aSI6InpHUm5mNzVPYUdIaG9rd2wiLCJzdWIiOjMsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.JNbMo91I1l9NeKQliAeec51yZqeNtCl6KeKkJ25WHqo"
          //
          //     }
          // )
      );
      return AudioConfirmPaymentModel.fromJson(result.data);
    }
    catch(e){
      print(e);
    }
  }
}