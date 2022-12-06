import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:istchrat/shared_components/colors.dart';

class main_content_teacher extends StatelessWidget {
  final String? icon;
  final Color? bgColor;
  final Function? onPresses;
  const main_content_teacher({
    Key? key,
    @required this.icon,
    @required this.bgColor,
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
        //  padding: EdgeInsetsDirectional.only(start: 10.w, end: 10.w),
        width: 100.w,
        height: 100.h,
        child: Center(
          child: Image.network(
            icon!,
            width: 80.w,
            height: 80.h,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
