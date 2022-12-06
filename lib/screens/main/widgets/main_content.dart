import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:istchrat/shared_components/colors.dart';

class MainContent extends StatelessWidget {
  final String? title;
  final String? icon;
  final Color? bgColor;
  final Color? txtColor;
  final Function? onPresses;

  const MainContent({
    Key? key,
    @required this.title,
    @required this.icon,
    @required this.bgColor,
    @required this.txtColor,
    @required this.onPresses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onPresses != null) {
          onPresses!();
        }
      },
      child: Container(
        margin: EdgeInsetsDirectional.only(start: 10.w, end: 10.w),
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(width: 1.0, color: lightGrey),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        width: 110.w,
        height: 120.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 15.h,
            ),
            SvgPicture.asset(
              icon!,
              height: 46.h,
            ),
            SizedBox(
              height: 10.h,
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
                child: Text(
                  title!,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: txtColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
