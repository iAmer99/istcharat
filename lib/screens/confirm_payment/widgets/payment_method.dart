import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:istchrat/shared_components/colors.dart';

import '../../../main.dart';

class PaymentMethod extends StatefulWidget {
  final Function(String) onMethodChange;
  final String value;

  const PaymentMethod(
      {Key? key, required this.onMethodChange, required this.value})
      : super(key: key);

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  late String value;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
      margin: EdgeInsets.only(top: 16.h,),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.h),
          border: Border.all(color: lightGrey,)
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          onChanged: (String? value) {
            widget.onMethodChange(value ?? "knet");
            setState(() {
              this.value  = value!;
            });
          },
          value: value,
          items: box.read('isUploading') && Platform.isIOS ? [
             DropdownMenuItem(
              child: Row(
                children: [
                  Image.asset("assets/images/apple.png", height: 27.h,),
                  SizedBox(width: 20.w,),
                  Text("In-App Purchase", style: TextStyle(color: grey, fontSize: 15.w),),
                ],
              ),
              value: "iap",
            ),
          ] : [
            DropdownMenuItem(
              child: Row(
                children: [
                  SvgPicture.asset("assets/icons/credit_card.svg", height: 27.h,),
                  SizedBox(width: 20.w,),
                  Text("credit_card".tr, style: TextStyle(color: grey, fontSize: 15.w),),
                ],
              ),
              value: "knet",
            ),
            DropdownMenuItem(
              child: Row(
                children: [
                  Icon(Icons.account_balance_wallet, size: 27.h, color: mainColor,),
                  SizedBox(width: 20.w,),
                  Text("wallet".tr, style: TextStyle(color: grey, fontSize: 15.w),),
                ],
              ),
              value: "wallet",
            ),
          ],
        ),
      ),
    );
  }
}