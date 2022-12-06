import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:istchrat/screens/login/login_screen.dart';
import 'package:istchrat/shared_components/widgets/rounded_yellow_button.dart';

class NoData extends StatelessWidget {
  const NoData({Key? key, this.login = false, this.img, this.msg}) : super(key: key);
  final bool login;
  final String? img;
  final String? msg;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
      if(!login)  img != null
            ? SvgPicture.asset(
                img!,
                height: 100.h,
                color: Colors.grey,
              )
            : Image.asset(
                "assets/images/noData.png",
                height: 100.h,
                fit: BoxFit.contain,
              ),
        SizedBox(
          height: 10.h,
        ),
        Text(login ? "login_to_continue".tr : msg != null ? msg! : "nodata".tr,
            style: TextStyle(
              fontSize:login ? 15.sp : 20.sp,
            )),
        SizedBox(
          height: 10.h,
        ),
        if (login)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: RoundedYellowButton(
              onTap: () {
                Get.to(() => LoginScreen(comeFromHome: true));
              },
              text: 'login'.tr,
            ),
          )
      ],
    ));
  }
}
