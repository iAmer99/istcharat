import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:istchrat/shared_components/colors.dart';

class TutorName extends StatelessWidget {
  const TutorName({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          "assets/icons/person.svg",
          height: 13.h,
        ),
        SizedBox(
          width: 10.w,
        ),
        Text(
          name,
          style: TextStyle(color: blueGrey, fontSize: 16.sp),
        ),
      ],
    );
  }
}
