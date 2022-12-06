import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:istchrat/custom_widgets/net_failed_widget.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/account_notifications/acc_notifications_cubit/acc_notifications_cubit.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/account_notifications/acc_notifications_cubit/acc_notifications_states.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/account_notifications/repo/AccountNotificationsModel.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:istchrat/shared_components/widgets/custom_app_bar.dart';

class AccountNotificationsScreen extends StatelessWidget {

  AccNotificationsCubit? cubit;
  AccountNotificationsModel? accNotificationsModel;
  bool isLoading = false;
  bool isError = false;
  List status = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=> AccNotificationsCubit()..getAccountNotifications(),
    child: BlocConsumer<AccNotificationsCubit,AccNotificationsStates>(
        listener: (context,state){},
      builder: (context,state){
          cubit = AccNotificationsCubit.get(context);
          isLoading = cubit!.isLoading;
          accNotificationsModel = cubit!.accNotificationsModel;
          isError = cubit!.isError;
          status = cubit!.status;

      return BlocProvider(create: (context)=>AccNotificationsCubit(),
      child: BlocConsumer<AccNotificationsCubit,AccNotificationsStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            appBar: CustomAppBar.appBar(context, text: "notifications_settings".tr),
            backgroundColor: Colors.white,
            body: isLoading == true ? Center(child: CircularProgressIndicator()) : Column(
              children: [
                SizedBox(height: 20.h,),
                Expanded(
                  child: isError == true ? NetFailedWidget(onPress: (){
                    cubit!.emit(AccNotificationsInitialState());
                    cubit!.getAccountNotifications();
                  }) :ListView.builder(
                    itemCount: accNotificationsModel!.data!.rows!.length,
                    itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(accNotificationsModel!.data!.rows![index].notification.toString(),
                                style: TextStyle(fontSize: 14.sp,color: darkGrey),),
                            ),
                            Switch(
                                value: status[index],
                                activeColor: yelloCollor,
                                onChanged: (value){
                                  cubit!.changeSwitchStatus(value, index);
                                  cubit!.updateNotifications(accNotificationsModel!.data!.rows![index].id.toString(),
                                      value == true? "1" : "0");
                                })
                          ],
                        ),
                      );

                    },),
                ),

              ],
            ),
          );
        },
      ),);
    }, ),);
  }
}

class Settings {
  int? id;
  int? status;

  Settings({this.id, this.status});

  Settings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    return data;
  }
}
