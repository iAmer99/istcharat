import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:istchrat/screens/teacher/teacher_waiting/details_screen/details_screen.dart';

import '../../../../shared_components/colors.dart';
import '../../account_screen/questions_and_answers/question_details/question_details_screen.dart';

class ConsultationItem extends StatelessWidget {
  ConsultationItem({
    Key? key,
    required this.price,
    required this.status,
    required this.consultationType,
    required this.time,
    this.question,
    this.answer,
    required this.reply,
    required this.delayed,
    required this.delayedTime,
    this.applyPress = true,
  }) : super(key: key);
  final String consultationType, status, price, time, delayedTime;
  final String? question, answer, reply;
  final bool delayed;
  final bool applyPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.h, vertical: 8.h),
      child: GestureDetector(
        onTap: () {
          if (applyPress) {
            print(reply.toString() + "teeeest");
            if (consultationType == "question_and_answer".tr) {
              Get.to(() => QuestionDetailsScreen(
                    question: question,
                    answer: answer,
                  ));
            } else {
              /*if(reply != null){
              Get.defaultDialog(
                title: "lecturer_notes".tr,
                content: Text(reply ?? "", style: TextStyle(fontSize: 15.sp),),
              );
            } */
              Get.to(() => DetailsScreen(
                    isUser: true,
                    consultationType: consultationType,
                    status: status,
                    price: price,
                    date: delayed ? delayedTime : time,
                    question: question,
                    answer: answer,
                    notes: reply,
                  ));
            }
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 18.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: lightGrey)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (consultationType.isNotEmpty)
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/document.svg",
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              "$consultationType",
                              style: TextStyle(
                                  fontSize: 12.sp, color: Colors.black),
                            ),
                          ],
                        ),
                      if (time.trim().isNotEmpty)
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/clock.svg",
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              delayed ? delayedTime : "$time",
                              style: TextStyle(
                                  fontSize: 12.sp, color: Colors.black),
                            ),
                          ],
                        ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (status.isNotEmpty || delayed)
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/waiting_icon.svg",
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              delayed && status == null ? "delayed".tr : status ?? "",
                              style: TextStyle(
                                  fontSize: 12.sp, color: Colors.black),
                            ),
                          ],
                        ),
                      if (price.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/dollar.svg",
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "$price",
                                style: TextStyle(
                                    fontSize: 12.sp, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
