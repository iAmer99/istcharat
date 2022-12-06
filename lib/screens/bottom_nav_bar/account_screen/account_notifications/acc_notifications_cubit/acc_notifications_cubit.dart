import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/account_notifications/acc_notifications_cubit/acc_notifications_states.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/account_notifications/repo/AccountNotificationsModel.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/account_notifications/repo/UpdateNotifications.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/account_notifications/repo/acc_notifications_repo.dart';

class AccNotificationsCubit extends Cubit<AccNotificationsStates>{

  AccNotificationsCubit() : super(AccNotificationsInitialState());

 static AccNotificationsCubit get(context)=> BlocProvider.of(context);

  AccountNotificationsModel? accNotificationsModel;
  AccNotificationsRepo accNotificationsRepo = AccNotificationsRepo();
  UpdateNotifications? updateNotificationsModel;
  bool isLoading = false;
  bool isError = false;
  List status = [];


  getAccountNotifications() async {
    try{
      isLoading = true;
      isError = false;
      accNotificationsModel = await accNotificationsRepo.getAccountNotifications();
      print(accNotificationsModel!.data!.rows![0].status);
      for(int x =0 ; x<accNotificationsModel!.data!.rows!.length; x++){
        status.add(accNotificationsModel!.data!.rows![x].status);
      }
      isLoading = false;
      print(status);
      emit(GetAccNotificationsSuccessfully());
    }
    catch(e){
      print(e);
      print(">>>>>>>>>>>>");
      isLoading = false;
      isError = true;
      emit(GetAccNotificationsError());
    }
  }

  updateNotifications(String id,String status) async {
    try{
      updateNotificationsModel = await accNotificationsRepo.updateNotifications(id,status);
      print(updateNotificationsModel!.data!.message);
      isLoading = false;
      emit(UpdateNotificationsSuccessfully());
    }
    catch(e){
      print(e);
      print(">>>>>>>>>>>>");
      isLoading = false;
      emit(UpdateNotificationsFailed());
    }
  }
  changeSwitchStatus(bool value,int index){
    status[index] = value;
    emit(ChangeSwitchStatus());
  }
}