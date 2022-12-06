import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:istchrat/shared_components/colors.dart';

class TitleText extends StatelessWidget {
  const TitleText({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(color: mainColor, fontSize: 15.h),
    );
  }
}
