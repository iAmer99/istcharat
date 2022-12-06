import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:istchrat/shared_components/colors.dart';

class TypeField extends StatelessWidget {
   TypeField({Key? key,required this.controller,this.onTap}) : super(key: key);
  TextEditingController? controller;
   Function()? onTap;


   @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Stack(
        alignment: AlignmentDirectional.centerEnd,
        children: [
          SizedBox(
            height: 50.w,
            child: TextField(
              controller: controller,
              onChanged: (String? value) {},
              decoration: InputDecoration(
                hintText: "write_message".tr,
                hintStyle: TextStyle(color: grey, fontSize: 15.h),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.h),
                    borderSide: const BorderSide(
                      color: lightGrey,
                    )),
              ),
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: 50.w,
              width: 50.w,
              decoration: BoxDecoration(
                color: yelloCollor,
                borderRadius: BorderRadius.circular(8.h),
              ),
              padding: EdgeInsets.symmetric(vertical: 15.w),
              child: SvgPicture.asset(
                'assets/icons/send.svg',
                color: darkGrey,
              ),
            ),
          )
        ],
      ),
    );
  }
}
