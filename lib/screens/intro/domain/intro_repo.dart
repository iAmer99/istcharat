import 'package:istchrat/screens/intro/domain/IntroModel.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';

class IntroRepo{

  getIntroData() async{
    try{
      final dio = DioUtilNew.dio;
      final result = await DioUtilNew.get("splash");
      return IntroModel.fromJson(result.data);
    }
    catch(e){
      print(e);
    }
  }
}