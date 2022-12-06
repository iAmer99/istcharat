import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DurationItem extends StatelessWidget{
  DurationItem(
      {Key? key,

      this.onPress,
        this.iconColor,
      this.borderColor,
      this.containerColor,
      this.time,
      this.price,
      this.textPriceColor,
        this.currency,
      this.textTimeColor})
      : super(key: key);

  Function()? onPress;
  Color? containerColor;
  Color? borderColor;
  Color? textTimeColor;
  Color? textPriceColor;
  Color? iconColor;
  String? time;
  String? price;
  String? currency;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          color: containerColor ,
          borderRadius: BorderRadius.circular(15.h),
          border: Border.all(
            color: borderColor! ,
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
        margin: EdgeInsetsDirectional.only(end: 20.w, top: 16.h),
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/icons/timer.svg',
              height: 45.h,
              color:  iconColor,
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              "$time",
              style: TextStyle(
                  color: textTimeColor, fontSize: 13.h),
            ),
            SizedBox(
              height: 3.h,
            ),
            Flexible(
              child: Text(
                "$price ${"USD".tr}",
                style: TextStyle(
                    color: textPriceColor ,
                    fontSize: 13.h),
              ),
            )
          ],
        ),
      ),
    );
  }
}
