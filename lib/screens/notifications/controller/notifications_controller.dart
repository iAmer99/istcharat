import 'package:get/get.dart';
import 'package:istchrat/screens/notifications/repository/model/NotificationsResponse.dart';
import 'package:istchrat/screens/notifications/repository/notifications_repository.dart';

class NotificationsController extends GetxController{
  bool lastPaginatePage = false;
  int page = 1;
  RxStatus status = RxStatus.loading();
  NotificationsResponse? data;

  final NotificationsRepository _repository = NotificationsRepository();

  Future getNotifications() async {
    status = RxStatus.loading();
    final response = await _repository.getNotifications();
    response.fold((error) {
      status = RxStatus.error(error);
      update();
    }, (data) {
      this.data = data;
      if(data.data?.rows == null || data.data!.rows!.isEmpty){
        status = RxStatus.empty();
        update();
      }else{
        status = RxStatus.success();
        update();
      }
    });
  }

  Future getMoreNotifications() async {
    if (!lastPaginatePage) {
      page = page + 1;
      final response = await _repository.getNotifications(paginatePage: page);
      response.fold(
          (error){}, (data) {
            if(data.data?.paginate?.currentPage == data.data?.paginate?.lastPage){
              lastPaginatePage = true;
            }
            if(data.data?.rows != null){
              this.data?.data?.rows?.addAll(data.data!.rows!);
              update();
            }
          });
    }
  }
}
