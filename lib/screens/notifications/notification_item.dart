import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:istchrat/screens/notifications/repository/model/NotificationsResponse.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({Key? key, required this.data}) : super(key: key);
  final Rows data;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      padding: const EdgeInsetsDirectional.all(5),
      margin: const EdgeInsetsDirectional.all(7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsetsDirectional.only(start: 10.w, end: 5.w, top: 5.h),
            decoration: BoxDecoration(
              color: darkBlue,
              border: Border.all(width: 1.0, color: lightGrey),
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            ),
            width: 80.w,
            height: 80.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: _getIcon(),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 5.w,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsetsDirectional.only(top: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    data.title ?? "",
                    style: TextStyle(fontSize: 14.sp, color: Colors.black),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Flexible(
                    child: Text(
                      data.body ?? "",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(fontSize: 14.sp, color: grey),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/icons/calendar.svg"),
                      SizedBox(
                        width: 3.w,
                      ),
                      Flexible(
                        child: Text(
                         "${data.date ?? ""} | ${data.time ?? ""}",
                          style:
                          TextStyle(fontSize: 13.sp, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1.0, color: lightGrey),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
    );
  }

  Widget _getIcon() {
    if (data.icon != null && data.icon!.isNotEmpty) {
      return Image.network(
        data.icon!,
        height: 60.h,
        width: 60.h,
        errorBuilder: (context, _, s) => SvgPicture.asset(
          "assets/icons/notification.svg",
          color: Colors.white,
          width: 30.w,
          height: 30.w,
        ),
      );
    } else {
      return SvgPicture.asset(
        "assets/icons/notification.svg",
        color: Colors.white,
        width: 30.w,
        height: 30.w,
      );
    }
  }
}
