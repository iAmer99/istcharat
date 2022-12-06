import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:istchrat/shared_components/colors.dart';

class CustomButton extends StatelessWidget {
 Function()? onTap;
 String? title;
 CustomButton({this.onTap,this.title});
  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding:  EdgeInsets.symmetric(horizontal: 30.0.w),
      child: GestureDetector(
        onTap: onTap!,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15.h),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: yelloCollor,
          ),
          child: Center(child: Text(title!
            ,style: TextStyle(
                color: darkGrey,
                fontSize: 17.sp
            ),)),
        ),
      ),
    )
    ;
  }
}
