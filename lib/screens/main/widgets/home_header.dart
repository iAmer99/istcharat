import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:istchrat/main.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:istchrat/shared_components/constants/constants.dart';

class HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsetsDirectional.only(start: 10, end: 10, top: 30, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      'welcome'.tr,
                      style: TextStyle(fontSize: 18, color: darkGrey),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    SvgPicture.asset("assets/icons/emoji.svg")
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'good_day_to_learn'.tr,
                  style: TextStyle(
                    fontSize: 15,
                    color: grey,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: yelloCollor,
              border: Border.all(width: 1.0, color: yelloCollor),
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            ),
            width: 70,
            height: 70,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Image.asset(
                "assets/images/app_logo.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getImage(){
    if(box.read(Constants.avatar.toString()) != null){
      return Image.network(box.read(Constants.avatar.toString()), fit: BoxFit.fill, errorBuilder: (context, _ , d)=> Image.asset(
        "assets/images/avatar1.png",
        fit: BoxFit.fill,
      ),);
    }else{
      return  Image.asset(
        "assets/images/avatar1.png",
        fit: BoxFit.fill,
      );
    }
  }
}
