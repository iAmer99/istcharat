import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:istchrat/shared_components/colors.dart';

class TeacherWaitingAppBar extends StatelessWidget {

  TeacherWaitingAppBar({this.title,this.onPress,this.widget});
  String? title;
  Function()? onPress;
  Widget? widget;
  @override
  Widget build(BuildContext context) {
    return   Container(
      height: MediaQuery.of(context).size.height * .15,
      width: double.infinity,
      color: Color(0xffFAFAFA),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
         if(Navigator.canPop(context)) GestureDetector(
            onTap: onPress,
            child:
            Container( margin: EdgeInsetsDirectional.only(start: 15.w,end: 10.w),
              decoration:BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: lightGrey
                  )
              ) ,
              padding: EdgeInsets.all(10.h),
              child: Icon(Icons.arrow_back_ios_outlined,
                size: 24.h,
                color: darkGrey,),
            ),
          ),
          Expanded(
            child: Center(
                child: Text(title!,style: TextStyle(fontSize: 15.sp,color: darkGrey),)),
          ),
          Container( margin: EdgeInsetsDirectional.only(start: 15.w,end: 10.w),
              padding: EdgeInsets.all(10.h),
              child: widget)

        ],
      ),
    );
  }
}
