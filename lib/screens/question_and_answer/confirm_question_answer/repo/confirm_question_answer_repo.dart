import 'package:istchrat/screens/question_and_answer/confirm_question_answer/repo/ConfirmQuestionAnswerModel.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';

class ConfirmQuestionAnswerRepo {

  getQuestionAnswerConfirmData(String coupon, String bookID,String consultationType) async {
    try {
      final dio = DioUtilNew.dio;
      final result = await DioUtilNew.get(
        "$consultationType/confirmAppointment/$bookID",
      );
      return ConfirmQuestionAnswerModel.fromJson(result.data);
    } catch (e) {
      print(e);
    }
  }
}
