import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:istchrat/screens/course_details/widgets/videolist/youtubplayer_wiget.dart';

import '../../../../shared_components/colors.dart';

class VideoItem extends StatelessWidget {
  final String index;
  final String? title;
  final String? date;
  final String url;

  const VideoItem(
      {Key? key, required this.index, this.title, required this.url, this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(YoutubePlayerWidget(
          url: url,
          title: title,
        ));
      },
      child: Container(
        margin: EdgeInsetsDirectional.all(10),
        padding: EdgeInsetsDirectional.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "$index.",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 18.sp, color: darkestGrey),
            ),
            SizedBox(
              width: 5.w,
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? "Video $index",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15.sp, color: Colors.black),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  if (date != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset("assets/icons/calendar.svg"),
                        SizedBox(
                          width: 3.w,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Flexible(
                          child: Text(
                            date!,
                            style:
                                TextStyle(fontSize: 13.sp, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  if (date != null)
                    SizedBox(
                      height: 5.h,
                    ),
                  Visibility(
                    visible: false,
                    child: Text(
                      "D.mustafa",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 13.sp, color: grey),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Center(
                  child: SvgPicture.asset("assets/icons/playbroken.svg")),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: yelloCollor, // border color
                shape: BoxShape.circle,
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: lightGrey)),
      ),
    );
  }
}
