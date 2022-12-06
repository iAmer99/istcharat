import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:istchrat/shared_components/colors.dart';

class TimeItem extends StatelessWidget {
   TimeItem({Key? key, this.containerColor,this.borderColor,this.textColor,this.time,this.onPress}) : super(key: key);
  String? time;
  Color? containerColor;
  Color? borderColor;
  Color? textColor;
   Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(15.h),
          border: Border.all(
            color: borderColor!,
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
        margin: EdgeInsetsDirectional.only(end: 3.w, top: 16.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(time!, style: TextStyle(color: textColor , fontSize: 17.h),),
            // SizedBox(width: 5.w,),
            // Text("A.M", style: TextStyle(color: isSelected ? Colors.white : grey, fontSize: 17.h),)
          ],
        ),
      ),
    );
  }
}
