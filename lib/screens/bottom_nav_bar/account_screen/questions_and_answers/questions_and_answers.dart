import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:istchrat/shared_components/widgets/custom_app_bar.dart';

class QuestionsAndAnswers extends StatelessWidget {
  const QuestionsAndAnswers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.appBar(context, text: "Questions And Answers"),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 8.h),
            child: Container(
              clipBehavior: Clip.antiAlias,
              height: 110.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.grey)),
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
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: lightGrey)),
                          child: SvgPicture.asset(
                            "assets/icons/question.svg",
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
                                "this an example for a text hat can be here",
                                style: TextStyle(
                                    fontSize: 12.sp, color: Colors.black),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset("assets/icons/calendar.svg"),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    "12 Octobar",
                                    style: TextStyle(
                                        fontSize: 11.sp, color: Colors.grey),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Container(
                                      height: 10.h,
                                      width: 2,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    "8 O`Clock PM",
                                    style: TextStyle(
                                        fontSize: 11.sp, color: Colors.grey),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 40.h,
                        width: 100.h,
                        decoration: BoxDecoration(
                            color: yelloCollor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25))),
                        child: Center(
                            child: Text(
                          "Continue",
                          style: TextStyle(fontSize: 13.sp),
                        )),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
