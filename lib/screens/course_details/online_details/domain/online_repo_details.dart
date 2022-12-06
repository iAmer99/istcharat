import 'package:istchrat/screens/course_details/models/course_details_model.dart';
import 'package:istchrat/screens/course_details/online_details/models/online_details_model.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';

class OnlineRepoDetails {
  Future<Online_details_model?> getOnlineDetails(int id) async {
    try {
      final dio = DioUtilNew.dio;
      final result = await DioUtilNew.get("onlineCourses/$id");
      return Online_details_model.fromJson(result.data);
    } catch (e) {
      print(e.toString());
      return Online_details_model();
    }
  }
}
