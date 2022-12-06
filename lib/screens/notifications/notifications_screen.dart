import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:istchrat/custom_widgets/custom_dialogs/nodata.dart';
import 'package:istchrat/screens/notifications/controller/notifications_controller.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:istchrat/shared_components/widgets/custom_app_bar.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import 'notification_item.dart';

class NotificationsScreen extends GetView<NotificationsController> {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        appBar: CustomAppBar.appBar(context, text: "notifications".tr),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: false,
              child: Container(
                margin:
                    EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 20.h),
                child:  Text(
                  "Today".tr,
                  style: const TextStyle(
                      fontSize: 17, color: darkBlue, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
           Expanded(
             child: GetBuilder<NotificationsController>(
               builder: (controller){
                 if(controller.status.isEmpty){
                   return NoData(
                     img: "assets/icons/notification.svg",
                     msg: "no_notifications".tr,
                   );
                 }else if(controller.status.isLoading){
                   return const Center(
                     child: CircularProgressIndicator(
                       color: mainColor,
                     ),
                   );
                 }else if(controller.status.isSuccess){
                   return LazyLoadScrollView(
                     onEndOfPage: (){
                       controller.getMoreNotifications();
                     },
                     child: ListView.builder(
                       itemCount: controller.data?.data?.rows?.length ?? 0,
                       itemBuilder: (context, index) => NotificationItem(data: controller.data!.data!.rows![index]),
                     ),
                   );
                 }else{
                  return Center(
                     child: Text(
                       controller.status.errorMessage ?? "",
                       style: TextStyle(color: mainColor, fontSize: 20.sp),
                     ),
                   );
                 }
               },
             ),
           ),
           /*Expanded(
             child: controller.obx(
                 (data) {
                   if(data?.data?.rows?.length == 0){
                     return NoData(
                       img: "assets/icons/notification.svg",
                       msg: "no_notifications".tr,
                     );
                   }else{
                     return LazyLoadScrollView(
                       onEndOfPage: (){
                         controller.getMoreNotifications();
                       },
                       child: ListView.builder(
                         itemCount: data?.data?.rows?.length ?? 0,
                         itemBuilder: (context, index) => NotificationItem(data: data!.data!.rows![index]),
                       ),
                     );
                   }
                 },
               onLoading: const Center(
                 child: CircularProgressIndicator(
                   color: mainColor,
                 ),
               ),
               onError: (error) => Center(
                 child: Text(
                   error ?? "",
                   style: TextStyle(color: mainColor, fontSize: 20.sp),
                 ),
               ),
             ),
           ), */
          ],
        ),
      ),
    );
  }
}
