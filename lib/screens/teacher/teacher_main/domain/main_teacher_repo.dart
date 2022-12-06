import 'package:istchrat/screens/teacher/teacher_main/models/MainTeacherModel.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';

class MainTeacherRepo{
  Future<MainTeacherModel?> getTeacherMain() async {
    try {
      final dio = DioUtilNew.dio;
      final result = await DioUtilNew.get("lecturer/home");
      return MainTeacherModel.fromJson(result.data);
    } catch (e) {
      print(e.toString());
      return MainTeacherModel();
    }
  }
}