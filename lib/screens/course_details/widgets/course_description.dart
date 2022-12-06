import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CourseDescription extends StatelessWidget {
  const CourseDescription({Key? key, required this.description}) : super(key: key);
  final String description;
  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: TextStyle(
        color: Colors.black,
        fontSize: 14.sp,
      ),
    );
  }
}
