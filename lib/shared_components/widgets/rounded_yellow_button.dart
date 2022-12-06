import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:istchrat/shared_components/colors.dart';

class RoundedYellowButton extends StatelessWidget {
  const RoundedYellowButton({Key? key, required this.text, required this.onTap}) : super(key: key);
  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52.h,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: ()=> onTap(),
        child: Text(
          text,
          style: TextStyle(fontSize: 15.sp, color: Colors.black),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(yelloCollor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.h),
            ))
        ),
      ),
    );
  }
}
