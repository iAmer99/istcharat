import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:istchrat/shared_components/colors.dart';

class CustomTextField extends StatelessWidget {
   CustomTextField(
      {Key? key,
      required this.iconImage,
      required this.hintText,
      this.isPassword = false,
      this.enabled = true,
      required this.myValidator,
      required this.keyboardType,
      required this.myFocusNode,
        this.controller,
      this.nextFocusNode,
        this.maxNum,
      this.onComplete, this.ignorePointer = false})
      : super(key: key);

  final String iconImage;
  final String hintText;
  final bool isPassword;
  final bool enabled;
  final String? Function(String?)? myValidator;
  final TextInputType keyboardType;
  final FocusNode myFocusNode;
  final FocusNode? nextFocusNode;
  final Function? onComplete;
  final TextEditingController? controller;
  int? maxNum;
  final bool ignorePointer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        height: 60.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: lightGrey)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SvgPicture.asset(iconImage),
            ),
            Expanded(
              child: Container(
                child: IgnorePointer(
                  ignoring: ignorePointer,
                  child: TextFormField(
                    enabled: enabled,
                    validator: myValidator!,
                    controller: controller,
                    keyboardType: keyboardType,
                    maxLength: maxNum,
                    textInputAction:
                    onComplete == null ? TextInputAction.next : TextInputAction.done,
                    focusNode: myFocusNode,

                    onEditingComplete: () {
                      if (onComplete == null) {
                        FocusScope.of(context).requestFocus(nextFocusNode);
                      } else {
                        FocusScope.of(context).unfocus();
                        onComplete!();
                      }
                    },

                    obscureText: isPassword,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                        hintText: hintText,
                        counterText: "",
                        hintStyle: TextStyle(color: darkGrey, fontSize: 15.sp),
                        border: InputBorder.none),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
