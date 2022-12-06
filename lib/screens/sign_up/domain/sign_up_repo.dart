import 'package:dio/dio.dart';
import 'package:istchrat/screens/sign_up/domain/sign_up_model1.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';

class SignUpRepo{

   Future<Response<dynamic>> signUp(String name, String email , String password, String phoneNumber, String countryCode) async {
      print("aaaaaaaaa");
      final dio = DioUtilNew.dio;
      final response = await DioUtilNew.post("auth/register",data: {
        "name" : name,
        "email" : email,
        "mobile" : phoneNumber,
        "password" : password,
        "country_code" : countryCode,
      },
        isLogin: true,
      );
      return response;
  }

  // signUp(String name, String email , String password, String phoneNumber) async {
  //
  //   final result = await DioHelper.getPostData(
  //     url: "/auth/register",
  //     data: {
  //       "name" : name,
  //       "email" : email,
  //       "mobile" : phoneNumber,
  //       "password" : password
  //     },
  //   );
  //   return SignUpModel.fromJson(jsonDecode(result.data));
  // }
}