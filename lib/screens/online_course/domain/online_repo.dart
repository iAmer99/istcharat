import 'package:istchrat/screens/online_course/models/online_model.dart';
import 'package:istchrat/screens/recorded_course/models/recorded_course_model.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';

class OnlineRepo {
  Future<OnlineModel?> getOnlineCourses() async {
    try {
      final dio = DioUtilNew.dio;
      final result = await DioUtilNew.get("onlineCourses?paginate=1000");
      return OnlineModel.fromJson(result.data);
    } catch (e) {
      print(e.toString());
      return OnlineModel();
    }
  }
  Future<OnlineModel?> getMyOnlineCourses() async {
    try {
      final dio = DioUtilNew.dio;
      final result = await DioUtilNew.get("onlineCourses/mylibrary?paginate=1000");
      print(result.data);
      return OnlineModel.fromJson(result.data);
    } catch (e) {
      print(e.toString());
      return OnlineModel();
    }
  }
}
