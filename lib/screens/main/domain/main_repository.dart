
import 'package:istchrat/screens/main/models/home_model.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';

class MainRepository {
  MainRepository();

  Future<HomeModel?> getHomeData() async {
    try {
      final dio = DioUtilNew.dio;
      final result = await DioUtilNew.get("home?paginate=1000");
      return HomeModel.fromJson(result.data);
    } catch (e) {
      print(e.toString());
      return HomeModel();
    }
  }
}
