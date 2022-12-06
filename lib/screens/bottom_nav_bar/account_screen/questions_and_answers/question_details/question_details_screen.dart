import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import 'package:istchrat/shared_components/widgets/custom_app_bar.dart';

import 'widgets/received_answer.dart';
import 'widgets/sent_question.dart';



class QuestionDetailsScreen extends StatelessWidget {
    QuestionDetailsScreen({Key? key,required this.answer,required this.question}) : super(key: key);
   String? question;
   String? answer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.appBar(context, text: "question_and_answer".tr),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children:  [
           if(question != null) SentQuestion(question: "$question", time: "", image: "",),
            if(answer != null) ReceivedAnswer(answer: "$answer", time: "", image: "",),
          ],
        ),
      ),
    );
  }
}
