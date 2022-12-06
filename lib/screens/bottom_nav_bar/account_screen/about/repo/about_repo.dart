import 'package:istchrat/screens/bottom_nav_bar/account_screen/about/repo/AboutModel.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';

class AboutRepo{

  final dio = DioUtilNew.dio;

  getAboutData(String type) async {
    try{
      final response = await DioUtilNew.get("pages/fetch?slug=$type");
      return AboutModel.fromJson(response.data);
    }
    catch(e){
      print(e);
      print("Eroooooorrrrrrrrr");
    }
  }
}