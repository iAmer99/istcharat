import 'package:istchrat/screens/confirm_payment/confirm_reservation_repo/ConfirmReservationModel.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';

class ConfirmReservationRepo{

  confirmReservation(String consultationType,String bookID,String coupon,String paymentMethod) async {
    try{
      final dio = DioUtilNew.dio;
      final result = await DioUtilNew.post("$consultationType/confirmAppointment/$bookID",
          data: {
            "payment_method": paymentMethod,
            "coupon": coupon,
            "currency" : "usd"
          },
      );
      final data = ConfirmReservationModel.fromJson(result.data);
      data.statusCode = result.statusCode;
      print(data.statusCode.toString() + "status");
      return data;
    }
    catch(e){
      print(e);
      print("erorrrrrrrrrrr");
    }
  }

}