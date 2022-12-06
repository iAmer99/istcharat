import 'package:istchrat/screens/course_details/models/course_details_model.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';

class RepoDetails {
  Future<CourseDetailsModel?> getRepoDetails(int id) async {
    try {
      final dio = DioUtilNew.dio;
      final result = await DioUtilNew.get("offlineCourses/$id");
      return CourseDetailsModel.fromJson(result.data);
    } catch (e) {
      print(e.toString());
      return CourseDetailsModel();
    }
  }
}
