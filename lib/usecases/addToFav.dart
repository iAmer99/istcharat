

import 'package:get/get.dart';
import 'package:istchrat/screens/login/login_screen.dart';
import 'package:istchrat/shared_components/constants/constants.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';

import '../main.dart';

class AddToFavUseCase {
  static  Future<bool> addToFav({required String id, required String urlSegment}) async{
    if(box.read(Constants.accessToken.toString()) != null){
      try {
        final dio = DioUtilNew.dio;
        final result = await DioUtilNew.post("favorites/$urlSegment/$id");
        if(result.statusCode == 201){
          return true;
        }else{
          return false;
        }
      } catch (e) {
        print(e.toString());
        return false;
      }
    }else{
      Get.to(()=> LoginScreen(comeFromHome: true,));
      return false;
    }
  }
}