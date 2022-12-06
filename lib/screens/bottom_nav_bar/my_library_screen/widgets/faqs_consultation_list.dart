import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../custom_widgets/custom_dialogs/nodata.dart';
import '../../../../shared_components/colors.dart';
import '../cubit/myLibrary_cubit.dart';
import '../cubit/myLibrary_states.dart';
import 'consultation_item.dart';

class FaqsConsultationList extends StatefulWidget {
  const FaqsConsultationList({Key? key}) : super(key: key);

  @override
  State<FaqsConsultationList> createState() => _FaqsConsultationListState();
}

class _FaqsConsultationListState extends State<FaqsConsultationList> {
  @override
  void initState() {
    context.read<MyLibraryCubit>().getFaqsConsultations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyLibraryCubit, MyLibraryStates>(
        buildWhen: (previous, current) => current is MyLibraryFaqsStates,
        builder: (context, state) {
          final cubit = MyLibraryCubit.get(context);
          if (state is MyLibraryFaqsLoadingState) {
            return Center(
                child: CircularProgressIndicator(
                  color: mainColor,
                ));
          } else if (state is MyLibraryFaqsErrorState) {
            return Center(
              child: Text(
                state.errorMsg,
                style: TextStyle(color: mainColor, fontSize: 20.sp),
              ),
            );
          } else {
            if (cubit.faqsData == null || cubit.faqsData?.length == 0) {
              return Center(
                child: NoData(
                  img: "assets/icons/question.svg",
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: cubit.faqsData?.length,
                  itemBuilder: (context, index) => ConsultationItem(
                    reply: cubit.faqsData?[index].reply,
                    price: cubit.faqsData?[index].price ?? "",
                    consultationType: "question_and_answer".tr,
                    status: cubit.faqsData?[index].status ?? "",
                    time: (cubit.faqsData?[index].date ?? "") +
                        " " +
                        (cubit.faqsData?[index].time ?? ""),
                    question: cubit.faqsData?[index].question,
                    answer: cubit.faqsData?[index].answer,
                    delayedTime:
                    '${cubit.faqsData?[index].delayedDate ?? ""} ${cubit.faqsData?[index].delayedTime ?? ""}',
                    delayed: cubit.faqsData?[index].delayed ?? false,
                  ));
            }
          }
        });
  }
}
