import 'package:dio/dio.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/contact_us/repo/ContactUsModel.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';

class ContactUsRepo{

  final dio = DioUtilNew.dio!;

  contactUs(String name, String email , String question) async {
    try{
      final response = await DioUtilNew.post("messages/send",data: {
        "name" : name,
        "email" : email,
        "question" : question,
      },);
      return ContactUsModel.fromJson(response.data);
    }
    catch(e){
      print(e);
      print("Eroooooorrrrrrrrr");
      if(e is DioError){
        print(e.response?.data.toString());
      }
      throw e;
    }

  }
}