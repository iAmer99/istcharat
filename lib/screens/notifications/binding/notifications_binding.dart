import 'package:get/get.dart';
import 'package:istchrat/screens/notifications/controller/notifications_controller.dart';

class NotificationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationsController()..getNotifications());
  }

}