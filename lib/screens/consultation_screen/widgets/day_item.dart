import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DayItem extends StatelessWidget {
   DayItem({Key? key,  this.containerColor,this.borderColor,
     this.onPress,this.dayKeyColor,this.daysColor,this.daysValue,this.daysKey}) : super(key: key);
   Function()? onPress;
   Color? containerColor;
   Color? borderColor;
   Color? daysColor;
   Color? dayKeyColor;
   String? daysValue;
   String? daysKey;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress ,
      child: Container(
        width: 95.w,
        decoration: BoxDecoration(
          color: containerColor!,
          borderRadius: BorderRadius.circular(15.h),
          border: Border.all(
            color: borderColor!,
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 3.w),
        margin: EdgeInsetsDirectional.only(end: 20.w),
        child: Column(
          children: [
            Text("$daysKey", style: TextStyle(color:  dayKeyColor , fontSize: 22.h),),
            SizedBox(height: 5.h,),
            Text("$daysValue", style: TextStyle(color:  daysColor, fontSize: 15.h),)
          ],
        ),
      ),
    );
  }
}
