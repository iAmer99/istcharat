import 'package:istchrat/screens/bottom_nav_bar/account_screen/questions_and_answers/questions/repo/QuestionsModel.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';

class QuestionsRepo{
  final dio = DioUtilNew.dio;

  getQuestions() async {
    try{
      print("aaaaaaaaa");
      final response = await DioUtilNew.get("faqs",
      queryParameters: {
        "paginate" : 10
      });
      return QuestionsModel.fromJson(response.data);
    }
    catch(e){
      print(e);
      print("Eroooooorrrrrrrrr");
    }
  }
}