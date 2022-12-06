
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:istchrat/shared_components/widgets/rounded_yellow_button.dart';


class NetFailedWidget extends StatelessWidget {
  Function() onPress;

  NetFailedWidget({required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child:   Padding(
            padding:  EdgeInsets.symmetric(horizontal: 50.0.w),
            child: RoundedYellowButton(text: "network_error_retry".tr, onTap: onPress),
          ),

    ));
  }
}