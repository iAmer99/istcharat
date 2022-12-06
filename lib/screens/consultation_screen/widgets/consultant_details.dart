import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:istchrat/shared_components/colors.dart';

class ConsultantDetails extends StatelessWidget {

  ConsultantDetails({this.videoConsultationModel});

  dynamic videoConsultationModel;

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.h),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 15.h),
        child: Row(
          children: [
            SizedBox(
              height: 99.h,
              width: 76.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14.h),
                child: Image.network(
                  videoConsultationModel?.data?.lecturer?.image ?? "",
                  errorBuilder: (context,_,o) => Image.asset("assets/images/no_image.jpg", fit: BoxFit.cover,),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 20.w,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(videoConsultationModel?.data?.lecturer?.name ?? "", style: TextStyle(color: Colors.black, fontSize: 15.w),),
                  SizedBox(height: 5.h,),
                  Text(videoConsultationModel?.data?.lecturer?.position ?? "", style: TextStyle(color: grey, fontSize: 15.w),),
                  SizedBox(height: 5.h,),
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/university.svg', height: 16.h,),
                      SizedBox(width: 5.w,),
                      Expanded(child: Text(videoConsultationModel?.data?.lecturer?.university ?? "", style: TextStyle(color: grey, fontSize: 15.w),)),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
