import 'package:istchrat/screens/question_and_answer/repo/QuestionAnswerModel1.dart';
import 'package:istchrat/screens/question_and_answer/repo/QuestionBookModel.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';

class QuestionAnswerRepo{
  getQuestionAnswerData(String consultationType) async {
    try{
      final dio = DioUtilNew.dio;
      final result = await DioUtilNew.get("$consultationType/availableAppointments");
      print(result.data.toString() + "OOOO");
      return QuestionAnswerModel1.fromJson(result.data);
    }
    catch(e){
      print(e);
      print("<<<<<<<<<>>>>>>>>>");
    }
  }

  getBookQuestionData(String question,String consultationType) async {
    try{
      final dio = DioUtilNew.dio;
      final result = await DioUtilNew.post("$consultationType/bookAppointment",
        data: {
          "question": question,
        },
      );
      return QuestionBookModel.fromJson(result.data);
    }
    catch(e){
      print(e);
    }
  }

}