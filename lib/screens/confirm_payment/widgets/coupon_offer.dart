import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:istchrat/shared_components/colors.dart';

class CouponOffer extends StatelessWidget {
  const CouponOffer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: 14.w,
      ),
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xffFFF8F0),
        borderRadius: BorderRadius.circular(10.h),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "coupon_discount".tr,
            style: TextStyle(color: yelloCollor, fontSize: 15.w),
          ),
        ],
      ),
    );
  }
}
