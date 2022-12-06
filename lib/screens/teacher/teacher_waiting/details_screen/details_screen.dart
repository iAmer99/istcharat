import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:istchrat/screens/bottom_nav_bar/my_library_screen/widgets/consultation_item.dart';
import 'package:istchrat/screens/teacher/logs/log_item.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:istchrat/shared_components/widgets/custom_app_bar.dart';
import 'package:istchrat/shared_components/widgets/rounded_yellow_button.dart';

import '../../../bottom_nav_bar/account_screen/questions_and_answers/question_details/widgets/received_answer.dart';
import '../../../bottom_nav_bar/account_screen/questions_and_answers/question_details/widgets/sent_question.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen(
      {Key? key,
      this.mobile,
      this.price,
      this.name,
      this.status,
      this.consultationType,
      this.date,
      this.categoryKey,
      this.id,
      this.notes,
      this.question,
      this.answer,
      this.isUser = false})
      : super(key: key);
  String? consultationType,
      status,
      name,
      price,
      date,
      mobile,
      categoryKey,
      id,
      notes,
      question,
      answer;
  final bool isUser;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late bool isFaqs;

  late bool isEmergency;

  @override
  void initState() {
    isFaqs = widget.categoryKey == "faqs";
    isEmergency = widget.categoryKey == "emergency_consultations";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar.appBar(context, text: "details".tr),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          widget.isUser
              ? ConsultationItem(
                  price: widget.price ?? "",
                  status: widget.status ?? "",
                  consultationType: widget.consultationType ?? "",
                  time: widget.date ?? "",
                  reply: widget.notes,
                  delayed: false,
                  question: widget.question,
                  answer: widget.answer,
                  applyPress: false,
                  delayedTime: "")
              : LogItem(
                  status: widget.status,
                  mobile: widget.mobile,
                  date: widget.date,
                  price: widget.price,
                  name: widget.name,
                  consultationType: widget.consultationType,
                  navigate: false,
                  showButton: false,
                  onEndLoading: () {},
                  onStartLoading: () {},
                ),
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
                child: Text(
                  "Notes".tr,
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: mainColor),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              // height: 200.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(15)),
              padding: EdgeInsets.all(20.h),
              child: Text(widget.notes ?? "no_notes".tr),
            ),
          ),
          if (isFaqs || isEmergency)
            SizedBox(
              height: 20.h,
            ),
          if (widget.question != null &&
                  widget.question!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  Text(
                    "Question".tr,
                    style: TextStyle(fontSize: 15.sp, color: mainColor),
                  ),
                ],
              ),
            ),
          if (widget.question != null &&
                  widget.question!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: ReceivedAnswer(
                answer: widget.question ?? "",
                time: "",
                image: "",
              ),
            ),
          if ( widget.answer != null && widget.answer!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  Text(
                    "Answer".tr,
                    style: TextStyle(fontSize: 15.sp, color: mainColor),
                  ),
                ],
              ),
            ),
          if (widget.answer != null && widget.answer!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: SentQuestion(
                question: widget.answer ?? "",
                time: "",
                image: "",
              ),
            ),
        ],
      ),
    );
  }
}
