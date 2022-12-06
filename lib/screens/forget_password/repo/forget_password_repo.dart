import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:istchrat/screens/forget_password/repo/ForgetPasswordModel.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';

class ForgetPasswordRepo{

  final dio = DioUtilNew.dio;

  Future<Either<String,ForgetPasswordModel >>forgetPassword(String email) async{
    try {
      final result = await DioUtilNew.post(
        "auth/forgetPassword",
        data: {
          "email" : email
        }
      );
      if(result.statusCode == 200){
        return Right(ForgetPasswordModel.fromJson(result.data));
      }else{
        return Left(ForgetPasswordModel.fromJson(result.data).data?.message ?? "unknown_error".tr);
      }
    } catch (e) {
      print(e);
      return Left("unknown_error".tr);
    }
  }

  Future<Either<String,ForgetPasswordModel >> verify(String email,String code) async{
    try {
      final result = await DioUtilNew.post(
        "auth/verify",
        data: {
          "email" : email,
          "validation_code": code
        }
      );
      if(result.statusCode == 200){
        return Right(ForgetPasswordModel.fromJson(result.data));
      }else{
        return Left(ForgetPasswordModel.fromJson(result.data).data?.message ?? "unknown_error".tr);
      }
    } catch (e) {
      print(e);
      return left("unknown_error".tr);
    }

  }

  Future<Either<String, ForgetPasswordModel>> resendCode(String email) async{
    try {
      final result = await DioUtilNew.post(
          "auth/requestNewCode",
          data: {
            "email" : email
          }
      );
     if(result.statusCode == 200){
       return Right(ForgetPasswordModel.fromJson(result.data));
     }else{
       return Left(ForgetPasswordModel.fromJson(result.data).data?.message ?? "unknown_error".tr);
     }
    } catch (e) {
      print(e);
      return Left("unknown_error".tr);
    }
  }

  Future<Either<String, ForgetPasswordModel>> resetNewPassword(String email,String code,String password) async{
    try {
      final result = await DioUtilNew.post(
        "auth/resetNewPassword",
        data: {
          "email" : email,
          "verification_code": code,
          "password": password,
          "password_confirmation": password
        }
      );
      if(result.statusCode == 200){
        return Right(ForgetPasswordModel.fromJson(result.data));
      }else{
        return Left(ForgetPasswordModel.fromJson(result.data).data?.message ?? "unknown_error".tr);
      }
    } catch (e) {
      print(e);
      return Left("unknown_error".tr);
    }
  }

}