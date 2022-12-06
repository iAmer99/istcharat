import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';


class SetDeviceTokenUseCase {
  static final Dio _dio = DioUtilNew.dio!;

  static Future set() async{
    return DioUtilNew.post("auth/fcmToken",
      data: {
        "fcm_token": await FirebaseMessaging.instance.getToken(),
      },
    );
  }
}