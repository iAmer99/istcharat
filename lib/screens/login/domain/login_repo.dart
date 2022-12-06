import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:istchrat/screens/login/domain/login_model.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';

class LoginRepo{
  final Dio _dio = DioUtilNew.dio!;

  Future<Either<String, LoginModel>> login(Map<String, String> loginData) async{
    try{
      final response = await _dio.post("auth/login", data: loginData,);
      final data = LoginModel.fromJson(response.data);
      return Right(data);
    }catch(error){
      if(error is DioError){
        if(error.type == DioErrorType.response){
          print(error.response?.data['data']['message']);
          return Left(error.response?.data['data']['message'] ?? "");
        }
      }
      return Left("unauthorized".tr);
    }
  }

  Future sendToken() async{
    return await _dio.post("auth/fcmToken",
      data: {
        "fcm_token": await FirebaseMessaging.instance.getToken(),
      },
    );
  }
}