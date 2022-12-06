
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/change_password/repo/ChangePasswordModel.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';

class ChangePasswordRepo{

   Future<Either<String, ChangePasswordModel>> changePassword(String oldPassword, String newPassword , String newPasswordConfirmation) async {
    try{
      final dio = DioUtilNew.dio;
      final response = await DioUtilNew.post("auth/update/password",data: {
        "old_password" : oldPassword,
        "new_password" : newPassword,
        "new_password_confirmation" : newPasswordConfirmation,
      },);
      if(response.statusCode == 200){
        return Right(ChangePasswordModel.fromJson(response.data));
      }else{
        return Left(ChangePasswordModel.fromJson(response.data).data?.message ?? "unknown_error".tr);
      }
    }
    catch(e){
      print(e);
      print("Eroooooorrrrrrrrr");
      return Left("unknown_error".tr);
    }

  }
}