import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Attachment_item extends StatelessWidget {
  const Attachment_item({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.w,
      height: 70.h,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset("assets/images/avatar.png"),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: lightGrey)),
    );
  }
}
