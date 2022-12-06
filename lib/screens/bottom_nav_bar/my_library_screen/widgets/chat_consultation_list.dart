import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../custom_widgets/custom_dialogs/nodata.dart';
import '../../../../shared_components/colors.dart';
import '../cubit/myLibrary_cubit.dart';
import '../cubit/myLibrary_states.dart';
import 'consultation_item.dart';

class ChatConsultationList extends StatefulWidget {
  const ChatConsultationList({Key? key}) : super(key: key);

  @override
  State<ChatConsultationList> createState() => _ChatConsultationListState();
}

class _ChatConsultationListState extends State<ChatConsultationList> {

  @override
  void initState() {
    context.read<MyLibraryCubit>().getChatConsultations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyLibraryCubit, MyLibraryStates>(
        buildWhen: (previous, current) => current is MyLibraryChatStates,
        builder: (context, state) {
          final cubit = MyLibraryCubit.get(context);
          if (state is MyLibraryChatLoadingState) {
            return Center(
                child: CircularProgressIndicator(
                  color: mainColor,
                ));
          } else if (state is MyLibraryChatErrorState) {
            return Center(
              child: Text(
                state.errorMsg,
                style: TextStyle(color: mainColor, fontSize: 20.sp),
              ),
            );
          } else {
            if (cubit.chatData == null || cubit.chatData?.length == 0) {
              return Center(
                child: NoData(
                  img: "assets/icons/chat.svg",
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: cubit.chatData?.length,
                  itemBuilder: (context, index) => ConsultationItem(
                    reply: cubit.chatData?[index].reply,
                    price: cubit.chatData?[index].price ?? "",
                    consultationType: "text_conversation".tr,
                    status: cubit.chatData?[index].status ?? "",
                    time: (cubit.chatData?[index].date ?? "") +
                        " " +
                        (cubit.chatData?[index].time ?? ""),
                    delayedTime:
                    '${cubit.chatData?[index].delayedDate ?? ""} ${cubit.chatData?[index].delayedTime ?? ""}',
                    delayed: cubit.chatData?[index].delayed ?? false,
                  ));
            }
          }
        });
  }
}
