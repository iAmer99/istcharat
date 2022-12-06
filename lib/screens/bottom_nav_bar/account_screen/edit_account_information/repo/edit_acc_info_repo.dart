import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/edit_account_information/repo/AccountInfoModel.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/edit_account_information/repo/EditAccInfoModel.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';

class EditAccInfoRepo{
  final dio = DioUtilNew.dio;

   getAccountInformation() async {
    try{
      print("aaaaaaaaa");
      final dio = DioUtilNew.dio;
      final response = await DioUtilNew.get("auth/me");
      return AccountInfoModel.fromJson(response.data);
    }
    catch(e){
      print(e);
      print("Eroooooorrrrrrrrr");
    }
  }

   editAccountInformation(String name, String mobile , String imageBase64) async {
     try{
       final dio = DioUtilNew.dio;
       final response = await DioUtilNew.post("auth/me",data: {
         "name" : name,
         "mobile" : mobile,
         "image_base64" : imageBase64,
       },);
       return EditAccInfoModel.fromJson(response.data);
     }
     catch(e){
       print(e);
       print("Eroooooorrrrrrrrr");
     }

   }

   Future<Either<String, bool>> deleteAccount() async{
     try{
       final response = await dio!.delete('users/remove-account');
       debugPrint("data test " + response.data.toString());
       return Right(true);
     }catch(error){
       debugPrint(error.toString());
       return Left("unknown_error".tr);
     }
   }
}