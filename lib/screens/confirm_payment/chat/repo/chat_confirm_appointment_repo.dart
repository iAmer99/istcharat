import 'package:istchrat/screens/confirm_payment/chat/repo/ChatConfirmAppoitnmentModel.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';

class ChatConfirmAppointmentRepo{

  getChatConfirmAppointmentData(String coupon,String bookID,String consultationType) async {
    try{
      final dio = DioUtilNew.dio;
      final result = await DioUtilNew.get("$consultationType/confirmAppointment/$bookID",
        // options: Options(
        //     headers: {
        //       'Authorization': "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYXBpLWlzdGNocmF0Lm1hemFkYWsubmV0XC9hcGlcL3YxXC9hdXRoXC9sb2dpbiIsImlhdCI6MTY0NjkwNTE0NiwiZXhwIjoxNjUwNTA1MTQ2LCJuYmYiOjE2NDY5MDUxNDYsImp0aSI6InpHUm5mNzVPYUdIaG9rd2wiLCJzdWIiOjMsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.JNbMo91I1l9NeKQliAeec51yZqeNtCl6KeKkJ25WHqo"
        //
        //     }
        // )
      );
      return ChatConfirmAppoitnmentModel.fromJson(result.data);
    }
    catch(e){
      print(e);
    }
  }
}