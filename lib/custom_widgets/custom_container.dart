import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:istchrat/shared_components/colors.dart';

class CustomContainer extends StatelessWidget {
  String? image;
  String? icon;
  String? subTitle;
  final String title;
  final String price;
  final Function removeFromFav;
  final String? date;

  CustomContainer(
      {Key? key,
      this.image,
      this.subTitle,
      this.icon,
      required this.price,
      required this.title,
      required this.removeFromFav, this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 8.h),
      child: Container(
        clipBehavior: Clip.antiAlias,
        height: 110.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: lightGrey)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    height: 73.h,
                    width: 73.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green,
                    ),
                    child: Image.network(
                      image!,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .4,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(fontSize: 12.sp, color: Colors.black),
                        ),
                        SizedBox(height: 5.h,),
                        if(date != null) Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture
                                .asset(
                                "assets/icons/calendar.svg"),
                            SizedBox(
                              width:
                              8.w,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Flexible(
                              child:
                              Text(
                                "${date}",
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h,),
                        Expanded(
                          child: Text(
                            "$price ${"USD".tr}",
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: yelloCollor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                        removeFromFav();
                      },
                      child: SvgPicture.asset(icon!),
                    ),
                  ),
                  Container(
                    height: 40.h,
                    width: 100.h,
                    decoration: BoxDecoration(
                        color: yelloCollor,
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(25))),
                    child: Center(
                        child: Text(
                      subTitle!,
                      style: TextStyle(fontSize: 13.sp),
                    )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
