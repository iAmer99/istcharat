import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:istchrat/shared_components/colors.dart';

class TeacherWaitingItem extends StatelessWidget {
   TeacherWaitingItem({Key? key,this.mobile,this.price,
     this.name,this.status,this.consultationType,this.time,
   this.onDelay,this.onRefuse,this.onAccept,this.isCall,this.onStartCall,
   this.delayContainerColor,this.rejectContainerColor,this.acceptContainerColor,this.rejectAllContainerColor, this.isChat = false}) : super(key: key);
   String? consultationType,status,name,price,time,mobile;
   Function()? onAccept;
   Function()? onRefuse;
   Function()? onDelay;
   Function()? onStartCall;
   bool? isCall;
   Color? acceptContainerColor;
   Color? rejectContainerColor;
   Color? delayContainerColor;
   Color? rejectAllContainerColor;
   final bool isChat;

   @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 18.h,vertical: 8.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal : 12.h, vertical: 18.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightGrey)
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/document.svg",
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          "$consultationType",
                          style: TextStyle(fontSize: 12.sp, color: Colors.black),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/user.svg",
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "$name",
                            style: TextStyle(fontSize: 12.sp, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/clock.svg",
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          "$time",
                          style: TextStyle(fontSize: 12.sp, color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/waiting_icon.svg",
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          "$status",
                          style: TextStyle(fontSize: 12.sp, color: Colors.black),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/dollar.svg",
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "$price",
                            style: TextStyle(fontSize: 12.sp, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/mobil.svg",
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          "$mobile",
                          style: TextStyle(fontSize: 12.sp, color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 15.h,),
            isCall == true  ?
                Row(
                  children: [
                    GestureDetector(
                      onTap: onStartCall,
                      child: Container(
                        padding : EdgeInsets.symmetric(vertical: 8.h,horizontal: 30.w) ,
                        decoration : BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(25)
                        ),
                        child:Text(isChat ? "start_chat".tr : "start_call".tr,style: TextStyle(fontSize: 12.sp,color: Colors.white),),
                      ),
                    ),
                  ],

                )
                : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: onAccept,
                  child: Container(
                    padding : EdgeInsets.symmetric(vertical: 8.h,horizontal: 30.w) ,
                    decoration : BoxDecoration(
                        color: acceptContainerColor,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: acceptContainerColor!)
                    ),
                    child:Text("accept".tr,style: TextStyle(fontSize: 12.sp,color: acceptContainerColor == mainColor ? Colors.white : darkGrey),),
                  ),
                ),
                GestureDetector(
                  onTap: onDelay,
                  child: Container(
                    padding : EdgeInsets.symmetric(vertical: 8.h,horizontal: 30.w) ,
                    decoration : BoxDecoration(
                        color: delayContainerColor,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: delayContainerColor!)
                    ),
                    child:Text("delay".tr,style: TextStyle(fontSize: 12.sp,color: darkGrey),),
                  ),
                ),
                GestureDetector(
                  onTap: onRefuse,
                  child: Container(
                    padding : EdgeInsets.symmetric(vertical: 8.h,horizontal: 30.w) ,
                    decoration : BoxDecoration(
                      color: rejectAllContainerColor!,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: rejectContainerColor!)
                    ),
                    child:Text("refuse".tr,style: TextStyle(fontSize: 12.sp,color: rejectAllContainerColor == Colors
                        .white ? redColor : darkGrey),),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
