import 'package:istchrat/screens/bottom_nav_bar/account_screen/account_notifications/account_notifications_screen.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/account_notifications/repo/AccountNotificationsModel.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/account_notifications/repo/UpdateNotifications.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';

class AccNotificationsRepo{

  getAccountNotifications() async {
    try{
      print("aaaaaaaaa");
      final dio = DioUtilNew.dio;
      final response = await DioUtilNew.get("notifications/settings");
      return AccountNotificationsModel.fromJson(response.data);
    }
    catch(e){
      print(e);
      print("Eroooooorrrrrrrrr");
    }
  }

  updateNotifications(String id, String status) async{
    final dio = DioUtilNew.dio;
    final response = await dio!.patch("notifications/settings",
      data: {
        "id" : id,
        "status" : status
      }
    );
    return UpdateNotifications.fromJson(response.data);
  }
}