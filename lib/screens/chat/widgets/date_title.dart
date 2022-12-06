import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DateTitle extends StatelessWidget {
  const DateTitle({Key? key, required this.date}) : super(key: key);
  final String date;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        date,
        style: TextStyle(
          color: const Color(0xffABABAB),
          fontSize: 15.w,
          fontWeight: FontWeight.w900,),
      ),
    );
  }
}
