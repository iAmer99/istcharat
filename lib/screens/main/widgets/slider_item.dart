import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../book_details/book_details.dart';
import '../../consultation_screen/audio_consultation/audio_consultation_screen.dart';
import '../../consultation_screen/chat_consultation/chat_consultation_screen.dart';
import '../../consultation_screen/consultation_screen.dart';
import '../../course_details/course_details_screen.dart';
import '../../course_details/online_details/online_course_details_screen.dart';
import '../../question_and_answer/question_and_answer_screen.dart';
import '../models/home_model.dart';

class SliderItem extends StatelessWidget {
  final Sliders? slider;

  const SliderItem({Key? key, required this.slider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (slider?.modelType != null && slider?.modelType == "books") {
          Get.to(BookDetails(
            id: slider?.modelID != null ? slider?.modelID.toString() : "",
          ));
        } else if (slider?.modelType != null &&
            slider?.modelType == "videoConsultations") {
          Get.to(ConsultationScreen());
        } else if (slider?.modelType != null &&
            slider?.modelType == "voiceConsultations") {
          Get.to(AudioConsultationScreen());
        } else if (slider?.modelType != null &&
            slider?.modelType == "chatConsultations") {
          Get.to(ChatConsultationScreen(
            title: "text_conversation".tr,
            consultationType: "chatConsultations",
          ));
        } else if (slider?.modelType != null &&
            slider?.modelType == "appointmentConsultations") {
          Get.to(ChatConsultationScreen(
            title: "book_place".tr,
            consultationType: "appointmentConsultations",
          ));
        } else if (slider?.modelType != null &&
            slider?.modelType == "emergencyConsultations") {
          Get.to(QuestionAndAnswerScreen(
            consultationType: "emergencyConsultations",
            title: "emergency_consultation".tr,
          ));
        } else if (slider?.modelType != null && slider?.modelType == "faqs") {
          Get.to(QuestionAndAnswerScreen(
            consultationType: "faqs",
            title: "Questandanswer".tr,
          ));
        }else if (slider?.modelType != null && slider?.modelType == "onlineCourses") {
          Get.to(() => OnlineCourseDetailsScreen(
            id: slider?.modelID,
          ));
        }
        else if (slider?.modelType != null && slider?.modelType == "offlineCourses") {
          Get.to(() => CourseDetailsScreen(
            id: slider?.modelID,
          ));
        }
      },
      child: Container(
        width: double.infinity,
        height: 200,
        child: FadeInImage(
          fit: BoxFit.fill,
          image: NetworkImage(slider?.url ?? ""),
          placeholder: const AssetImage("assets/images/no_image.jpg"),
          imageErrorBuilder: (ctx, e, _) =>
              Image.asset("assets/images/no_image.jpg"),
        ),
      ),
    );
  }
}
