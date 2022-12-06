import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/questions_and_answers/question_details/question_details_screen.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/questions_and_answers/questions/cubit/questions_cubit.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/questions_and_answers/questions/cubit/questions_states.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/questions_and_answers/questions/repo/QuestionsModel.dart';

import 'package:istchrat/shared_components/colors.dart';
import 'package:istchrat/shared_components/widgets/custom_app_bar.dart';

import '../../../../../custom_widgets/custom_dialogs/nodata.dart';
import 'widgets/question_widget.dart';

class QuestionsScreen extends StatelessWidget {
   QuestionsScreen({Key? key}) : super(key: key);
 QuestionsModel? questionsModel;
 QuestionsCubit? cubit;
   bool isLoading = false;
   bool isError = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>QuestionsCubit()..getQuestions(),
    child: BlocConsumer<QuestionsCubit,QuestionsStates>(
        listener: (context,state){},
      builder: (context,state){
          cubit = QuestionsCubit.get(context);
          questionsModel = cubit!.questionsModel;
          isError = cubit!.isError;
          isLoading = cubit!.isLoading;

      return Scaffold(
        appBar: CustomAppBar.appBar(context, text: "question_and_answer".tr),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: isLoading == true ? Center(child: CircularProgressIndicator()) : Column(
            children: [
              Expanded(
                child: questionsModel?.data?.rows?.length == null || questionsModel?.data?.rows?.length == 0 ? Center(
                  child: NoData(),
                ) : ListView.builder(
                  itemCount: questionsModel?.data?.rows?.length ?? 0,
                    itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: QuestionWidget(
                      question:
                      questionsModel!.data!.rows![index].question.toString(),
                      date: "${questionsModel!.data!.rows![index].date} | ${questionsModel!.data!.rows![index].time}",
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>  QuestionDetailsScreen(
                          answer: questionsModel!.data!.rows![index].answer,
                          question: questionsModel!.data!.rows![index].question,
                        )));
                      },
                    ),
                  );
                }),
              )
            ],
          ),
        ),
      );
    }, ),);
  }
}
