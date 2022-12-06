import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:istchrat/shared_components/colors.dart';

class CouponFormField extends StatelessWidget {
   CouponFormField({Key? key,required this.controller,this.onTap}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
   Function()? onTap;
   TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 2,
            child: TextFormField(
              keyboardType: TextInputType.number,
              validator: (value){
                if(value!.isEmpty){
                  return "Please Enter Coupon";
                }
              },
              controller: controller,
              decoration: InputDecoration(
                hintText: "enter_discount_coupon".tr,
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 10.w),
                  child: SvgPicture.asset(
                    'assets/icons/offer.svg',
                    height: 20.h,
                  ),
                ),
                prefixIconConstraints: BoxConstraints(
                  maxHeight: 40.h,
                  maxWidth: 40.h,
                  minHeight: 24.h,
                  minWidth: 24.h,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 5.w),
                hintStyle: TextStyle(color: grey, fontSize: 15.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.h),
                  borderSide: const BorderSide(
                    color: lightGrey,
                  )
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: ElevatedButton(
              onPressed: onTap,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Text(
                  "validate".tr,
                  style: TextStyle(color: mainColor, fontSize: 15.w),
                ),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.transparent),
                  shadowColor: MaterialStateProperty.all(Colors.transparent),
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  foregroundColor: MaterialStateProperty.all(Colors.transparent),
                  elevation: MaterialStateProperty.all(0),
                  minimumSize: MaterialStateProperty.all(Size(89.w, 40.h)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.h),
                    side: const BorderSide(color: mainColor),
                  ))
              ) ,
            ),
          )
        ],
      ),
    );
  }
}
