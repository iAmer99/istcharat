import 'package:istchrat/screens/recorded_course/models/recorded_course_model.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';

class RecordedRepo {
  Future<Recorded_course_model?> getRecordedCourses() async {
    try {
      final dio = DioUtilNew.dio;
      final result = await DioUtilNew.get("offlineCourses?paginate=1000");
      return Recorded_course_model.fromJson(result.data);
    } catch (e) {
      print(e.toString());
      return Recorded_course_model();
    }
  }
  Future<Recorded_course_model?> getMyRecordedCourses() async {
    try {
      final dio = DioUtilNew.dio;
      final result = await DioUtilNew.get("offlineCourses/mylibrary?paginate=1000");
      return Recorded_course_model.fromJson(result.data);
    } catch (e) {
      print(e.toString());
      return Recorded_course_model();
    }
  }
}
