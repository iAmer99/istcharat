import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../shared_components/colors.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({Key? key, required this.balance, required this.currency}) : super(key: key);
  final String balance;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 220.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.circular(20.h),
          ),
        ),
        Align(
          alignment: AlignmentDirectional.topStart,
          child: Container(
            height: 150.h,
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(250.h)),
            ),
          ),
        ),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Container(
            height: 220.h,
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadiusDirectional.horizontal(
                  end: Radius.circular(250.h)),
            ),
          ),
        ),
        Align(
          alignment: AlignmentDirectional.topStart,
          child: Padding(
              padding: EdgeInsets.all(15.h),
              child: Text(
                "wallet_header".tr,
                style: TextStyle(color: Colors.white, fontSize: 18.sp),
              )),
        ),
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 25.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  balance,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  currency,
                  style: TextStyle(color: Colors.white, fontSize: 18.sp),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
