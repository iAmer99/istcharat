import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:istchrat/custom_widgets/custom_dialogs/failed_dialog/failed_dialog.dart';
import 'package:istchrat/custom_widgets/custom_dialogs/success_dialog/custom_success_dialog.dart';
import 'package:istchrat/custom_widgets/net_failed_widget.dart';
import 'package:istchrat/screens/chat/chat_screen.dart';
import 'package:istchrat/screens/dialing/dialing_screen.dart';
import 'package:istchrat/screens/teacher/logs/cubit/logs_cubit.dart';
import 'package:istchrat/screens/teacher/logs/cubit/logs_states.dart';
import 'package:istchrat/screens/teacher/logs/repo/LogsCategoriesModel.dart';
import 'package:istchrat/screens/teacher/logs/repo/LogsItemsModel1.dart';
import 'package:istchrat/screens/teacher/teacher_waiting/delay_screen/delay_screen.dart';
import 'package:istchrat/screens/teacher/teacher_waiting/details_screen/details_screen.dart';
import 'package:istchrat/screens/teacher/teacher_waiting/teacher_waiting_appbar.dart';
import 'package:istchrat/screens/teacher/teacher_waiting/teacher_waiting_item.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:istchrat/shared_components/widgets/rounded_yellow_button.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../custom_widgets/custom_dialogs/nodata.dart';
import '../../../shared_components/helper_functions.dart';
import '../../bottom_nav_bar/account_screen/questions_and_answers/question_details/widgets/received_answer.dart';

class TeacherWaitingScreen extends StatefulWidget {
  TeacherWaitingScreen(
      {Key? key,
      required this.categoryKey,
      required this.comeFromMain,
      required this.title, this.index = 0})
      : super(key: key);
  final String categoryKey;
  final bool comeFromMain;
  final String title;
  final int index;

  @override
  State<TeacherWaitingScreen> createState() => _TeacherWaitingScreenState();
}

class _TeacherWaitingScreenState extends State<TeacherWaitingScreen> {
  LogsItemsModel1? itemModel;

  LogsCubit? cubit;

  bool isLoading = true;

  bool itemsLoading = true;

  LogsCategoriesModel? categoriesModel;

  int selectedTap = 0;

  int categoryKeyIndex = 0;

  TextEditingController controller = TextEditingController();
  TextEditingController answerController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool acceptButtonActive = true;

  bool rejectButtonActive = true;

  bool delayButtonActive = true;

  String selectedStatus = 'pending';

  List<String> status = ["pending", "approved", "rejected", "delayed"];
  bool isError = false;

  @override
  void initState() {
    print("index: ${widget.index}");
    categoryKeyIndex = widget.index;
    selectedTap = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        if (widget.comeFromMain == true) {
          return LogsCubit()
            ..getLogsItems(widget.categoryKey, '', '', selectedStatus);
        }
        return LogsCubit()..getLogsCategories(index: widget.index)..checkSelectedTap(widget.index);
      },
      child: BlocConsumer<LogsCubit, LogsStates>(
        listener: (context, state) {
          if (state is AcceptedSuccessfullyState) {
            controller.text = "";
            Get.defaultDialog(
              title: "",
              content: CustomSuccessDialog(
                message: state.message,
              ),
            );
          } else if (state is AcceptedErrorState) {
            failedDialog(context: context, message: state.errorMsg);
          }
        },
        builder: (context, state) {
          cubit = LogsCubit.get(context);
          categoriesModel = cubit!.logsCategoriesModel;
          isLoading = cubit!.isLoading;
          itemModel = cubit!.itemModel;
          itemsLoading = cubit!.logsItemsLoading;
          selectedTap = cubit!.selectedTap;
          isError = cubit!.isError;
          print(fromDate);
          print(toDate);
          return Scaffold(
            backgroundColor: Colors.white,
            body: ModalProgressHUD(
              inAsyncCall: state is AcceptedLoadingState,
              child: Column(
                children: [
                  TeacherWaitingAppBar(
                    title: widget.title,
                    onPress: () {
                      Get.back();
                    },
                    widget: GestureDetector(
                      onTap: () {
                        Get.defaultDialog(title: '', content: filterDialog());
                      },
                      child: SvgPicture.asset(
                        "assets/icons/filter.svg",
                        width: 30.w,
                        height: 30.h,
                      ),
                    ),
                  ),
                  Expanded(
                    child: isLoading == true
                        ? Center(child: CircularProgressIndicator())
                        : isError == true
                            ? NetFailedWidget(onPress: () {
                                cubit!.emit(LogsInitialStates());
                                cubit!.getLogsCategories();
                              })
                            : Column(
                                children: [
                                  widget.comeFromMain == true
                                      ? SizedBox()
                                      : Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.h, vertical: 15.h),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: [
                                                for (var index = 0;
                                                    index <
                                                        categoriesModel!
                                                            .data!.rows!.length;
                                                    index++)
                                                  _buildTypeTap(
                                                      index: index,
                                                      title: categoriesModel!
                                                          .data!
                                                          .rows![index]
                                                          .value
                                                          .toString(),
                                                      icon: getIconPath(
                                                          categoriesModel!.data!
                                                              .rows![index].key
                                                              .toString())),
                                              ],
                                            ),
                                          ),
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "from".tr,
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              color: yelloCollor),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            _selectFromDate(context);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 40.w,
                                                vertical: 8.h),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: lightGrey),
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            child: Text(
                                              fromDate
                                                  .toString()
                                                  .substring(0, 10),
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: darkGrey),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "to".tr,
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              color: yelloCollor),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            _selectToDate(context);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 40.w,
                                                vertical: 8.h),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: lightGrey),
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            child: Text(
                                              toDate
                                                  .toString()
                                                  .substring(0, 10),
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: darkGrey),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: itemsLoading == true
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : itemModel!.data!.rows!.isEmpty
                                            ? Container(
                                                child: Center(
                                                    child: NoData(
                                                        img: widget.comeFromMain
                                                            ? getIconPath(widget
                                                                .categoryKey)
                                                            : getIconPath(
                                                                categoriesModel!
                                                                    .data!
                                                                    .rows![
                                                                        selectedTap]
                                                                    .key
                                                                    .toString()))),
                                              )
                                            : LazyLoadScrollView(
                                                onEndOfPage: () {
                                                  if (cubit != null &&
                                                      !cubit!
                                                          .lastPaginatePage) {
                                                    cubit!.getMoreLogsItems(
                                                        categoriesModel!
                                                            .data!
                                                            .rows![
                                                                categoryKeyIndex]
                                                            .key
                                                            .toString(),
                                                        "",
                                                        "",
                                                        selectedStatus);
                                                  }
                                                },
                                                child: ListView.builder(
                                                    itemCount: itemModel!
                                                        .data!.rows!.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final key = widget
                                                              .comeFromMain
                                                          ? widget.categoryKey
                                                          : categoriesModel!
                                                              .data!
                                                              .rows![
                                                                  categoryKeyIndex]
                                                              .key;
                                                      return GestureDetector(
                                                        onTap: () {
                                                          Get.to(
                                                              () =>
                                                                  DetailsScreen(
                                                                    name: itemModel!
                                                                        .data!
                                                                        .rows![
                                                                            index]
                                                                        .username,
                                                                    consultationType: itemModel!
                                                                        .data!
                                                                        .rows![
                                                                            index]
                                                                        .type,
                                                                    price: itemModel!
                                                                        .data!
                                                                        .rows![
                                                                            index]
                                                                        .price,
                                                                    date: itemModel!.data!.rows![index].delayed ??
                                                                            false
                                                                        ? "${itemModel!.data!.rows![index].delayedDate ?? ""} ${itemModel!.data!.rows![index].delayedTime ?? ""}"
                                                                        : itemModel!.data!.rows![index].date! +
                                                                            "  " +
                                                                            itemModel!.data!.rows![index].time!,
                                                                    mobile: itemModel!
                                                                        .data!
                                                                        .rows![
                                                                            index]
                                                                        .mobile,
                                                                    status: itemModel!
                                                                        .data!
                                                                        .rows![
                                                                            index]
                                                                        .status,
                                                                    categoryKey: widget.comeFromMain ==
                                                                            true
                                                                        ? widget
                                                                            .categoryKey
                                                                        : categoriesModel!
                                                                            .data!
                                                                            .rows![categoryKeyIndex]
                                                                            .key,
                                                                    id: itemModel!
                                                                        .data!
                                                                        .rows![
                                                                            index]
                                                                        .id,
                                                                    question: itemModel!
                                                                        .data!
                                                                        .rows![
                                                                            index]
                                                                        .question,
                                                                    answer: itemModel!
                                                                        .data!
                                                                        .rows![
                                                                            index]
                                                                        .answer,
                                                                  ));
                                                        },
                                                        child:
                                                            TeacherWaitingItem(
                                                          acceptContainerColor:
                                                              itemModel!
                                                                          .data!
                                                                          .rows![
                                                                              index]
                                                                          .approvedBtn! ==
                                                                      false
                                                                  ? Colors.grey
                                                                      .shade300
                                                                  : mainColor,
                                                          delayContainerColor: itemModel!
                                                                      .data!
                                                                      .rows![
                                                                          index]
                                                                      .delayedBtn! ==
                                                                  false
                                                              ? Colors
                                                                  .grey.shade300
                                                              : yelloCollor,
                                                          rejectContainerColor:
                                                              itemModel!
                                                                          .data!
                                                                          .rows![
                                                                              index]
                                                                          .rejectedBtn! ==
                                                                      false
                                                                  ? Colors.grey
                                                                      .shade300
                                                                  : redColor,
                                                          rejectAllContainerColor:
                                                              itemModel!
                                                                          .data!
                                                                          .rows![
                                                                              index]
                                                                          .rejectedBtn! ==
                                                                      false
                                                                  ? Colors.grey
                                                                      .shade300
                                                                  : Colors
                                                                      .white,
                                                          onStartCall: () {
                                                            if (key ==
                                                                    "voice_consultations" ||
                                                                key ==
                                                                    "video_consultations") {
                                                              Get.to(() => DialingScreen(
                                                                  isVideo: categoriesModel!
                                                                      .data!
                                                                      .rows![
                                                                          categoryKeyIndex]
                                                                      .key
                                                                      .toString()
                                                                      .contains(
                                                                          "video"),
                                                                  id: itemModel!
                                                                      .data!
                                                                      .rows![
                                                                          index]
                                                                      .id
                                                                      .toString(),
                                                                  categoryKey: key
                                                                      .toString(),
                                                                  pic: "",
                                                                  name: itemModel!
                                                                      .data!
                                                                      .rows![
                                                                          index]
                                                                      .username
                                                                      .toString()));
                                                            } else if (key ==
                                                                "chat_consultations") {
                                                              Get.to(() =>
                                                                  ChatScreen(
                                                                    isTeacher:
                                                                        true,
                                                                    id: int.parse(itemModel!
                                                                        .data!
                                                                        .rows![
                                                                            index]
                                                                        .id
                                                                        .toString()),
                                                                    image: '',
                                                                    toUserName: itemModel!
                                                                            .data!
                                                                            .rows![index]
                                                                            .username ??
                                                                        "",
                                                                  ));
                                                            }
                                                          },
                                                          isCall: (itemModel!
                                                                          .data!
                                                                          .rows![
                                                                              index]
                                                                          .buttonStatus ==
                                                                      null ||
                                                                  key ==
                                                                      "faqs" ||
                                                                  key ==
                                                                      "emergency_consultations" ||
                                                                  key ==
                                                                      "appointment_consultations")
                                                              ? false
                                                              : true,
                                                          isChat: key ==
                                                              "chat_consultations",
                                                          onAccept: itemModel!
                                                                      .data!
                                                                      .rows![
                                                                          index]
                                                                      .approvedBtn! ==
                                                                  false
                                                              ? () {}
                                                              : () {
                                                                  if (key ==
                                                                      "faqs") {
                                                                    Get.defaultDialog(
                                                                      title: "",
                                                                      content: answerQuestionDialog(
                                                                          context,
                                                                          itemModel!
                                                                              .data!
                                                                              .rows![
                                                                                  index]
                                                                              .id
                                                                              .toString(),
                                                                          itemModel!.data!.rows![index].question ??
                                                                              ""),
                                                                    );
                                                                  } else if (key ==
                                                                      "emergency_consultations") {
                                                                    Get.defaultDialog(
                                                                      title: "",
                                                                      content: answerQuestionDialog(
                                                                          context,
                                                                          itemModel!
                                                                              .data!
                                                                              .rows![
                                                                                  index]
                                                                              .id
                                                                              .toString(),
                                                                          itemModel!.data!.rows![index].question ??
                                                                              "",
                                                                          isEmergency:
                                                                              true),
                                                                    );
                                                                  } else {
                                                                    cubit!.acceptOrDecline(
                                                                        key
                                                                            .toString(),
                                                                        itemModel!
                                                                            .data!
                                                                            .rows![index]
                                                                            .id
                                                                            .toString(),
                                                                        "approved",
                                                                        "",
                                                                        "",
                                                                        "",
                                                                        selectedStatus,
                                                                        "");
                                                                  }
                                                                },
                                                          onRefuse: itemModel!
                                                                      .data!
                                                                      .rows![
                                                                          index]
                                                                      .rejectedBtn! ==
                                                                  false
                                                              ? () {}
                                                              : () {
                                                                  Get.defaultDialog(
                                                                    title: "",
                                                                    content: rejectReasonDialog(
                                                                        context,
                                                                        itemModel!
                                                                            .data!
                                                                            .rows![index]
                                                                            .id
                                                                            .toString()),
                                                                  );
                                                                },
                                                          onDelay: itemModel!
                                                                      .data!
                                                                      .rows![
                                                                          index]
                                                                      .delayedBtn! ==
                                                                  false
                                                              ? () {}
                                                              : () {
                                                                  Get.to(() =>
                                                                      DelayScreen(
                                                                        name: itemModel!
                                                                            .data!
                                                                            .rows![index]
                                                                            .username,
                                                                        consultationType: itemModel!
                                                                            .data!
                                                                            .rows![index]
                                                                            .type,
                                                                        price: itemModel!
                                                                            .data!
                                                                            .rows![index]
                                                                            .price,
                                                                        date: itemModel!.data!.rows![index].date! +
                                                                            "  " +
                                                                            itemModel!.data!.rows![index].time!,
                                                                        mobile: itemModel!
                                                                            .data!
                                                                            .rows![index]
                                                                            .mobile,
                                                                        status: itemModel!
                                                                            .data!
                                                                            .rows![index]
                                                                            .status,
                                                                        categoryKey: widget.comeFromMain ==
                                                                                true
                                                                            ? widget.categoryKey
                                                                            : categoriesModel!.data!.rows![categoryKeyIndex].key,
                                                                        id: itemModel!
                                                                            .data!
                                                                            .rows![index]
                                                                            .id,
                                                                      ));
                                                                },
                                                          name: itemModel!
                                                              .data!
                                                              .rows![index]
                                                              .username,
                                                          consultationType:
                                                              itemModel!
                                                                  .data!
                                                                  .rows![index]
                                                                  .type,
                                                          price: itemModel!
                                                              .data!
                                                              .rows![index]
                                                              .price,
                                                          time: selectedStatus ==
                                                                  "delayed"
                                                              ? itemModel!
                                                                      .data!
                                                                      .rows![
                                                                          index]
                                                                      .delayedDate! +
                                                                  "  " +
                                                                  itemModel!
                                                                      .data!
                                                                      .rows![
                                                                          index]
                                                                      .delayedTime!
                                                              : itemModel!
                                                                      .data!
                                                                      .rows![
                                                                          index]
                                                                      .date! +
                                                                  "  " +
                                                                  itemModel!
                                                                      .data!
                                                                      .rows![
                                                                          index]
                                                                      .time!,
                                                          mobile: itemModel!
                                                              .data!
                                                              .rows![index]
                                                              .mobile,
                                                          status: itemModel!
                                                              .data!
                                                              .rows![index]
                                                              .status,
                                                        ),
                                                      );
                                                    }),
                                              ),
                                  )
                                ],
                              ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTypeTap({
    required int index,
    required String title,
    required String icon,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: GestureDetector(
        onTap: () {
          categoryKeyIndex = index;
          print(categoryKeyIndex);
          cubit!.checkSelectedTap(index);
          cubit!.getLogsItems(
              categoriesModel!.data!.rows![index].key.toString(),
              "",
              "",
              selectedStatus);
        },
        child: Container(
          width: 120.w,
          height: 110.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: selectedTap == index ? mainColor : Colors.white,
              border: Border.all(color: mainColor)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
            child: Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  icon,
                  height: 40.h,
                  color: selectedTap == index ? Colors.white : null,
                ),
                SizedBox(
                  height: 7.h,
                ),
                Flexible(
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: selectedTap == index ? Colors.white : mainColor),
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }

  rejectReasonDialog(BuildContext context, String id) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  Text(
                    "reject_reason".tr,
                    style: TextStyle(fontSize: 15.sp, color: mainColor),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
              child: TextFormField(
                controller: controller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "reject_reason_validation".tr;
                  }
                },
                decoration: InputDecoration(
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: lightGrey)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: lightGrey)),
                  hintText: "write_reject_reason".tr,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: lightGrey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: lightGrey),
                  ),
                ),
                maxLines: 8,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: RoundedYellowButton(
                  text: "send".tr,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      final key = widget.comeFromMain
                          ? widget.categoryKey
                          : categoriesModel!.data!.rows![categoryKeyIndex].key;
                      Navigator.pop(context);
                      cubit!.acceptOrDecline(key.toString(), id, "rejected",
                          controller.text, "", "", selectedStatus, "");
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  answerQuestionDialog(BuildContext context, String id, String question,
      {bool isEmergency = false}) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 15.h,
            ),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: ReceivedAnswer(
                answer: "$question",
                time: "",
                image: "",
              ),
            ),
            if (!isEmergency)
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
            if (!isEmergency)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                child: TextFormField(
                  controller: answerController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter your answer";
                    }
                  },
                  decoration: InputDecoration(
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: lightGrey)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: lightGrey)),
                    hintText: "write your answer",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: lightGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: lightGrey),
                    ),
                  ),
                  maxLines: 8,
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: RoundedYellowButton(
                  text: isEmergency ? "accept".tr : "send".tr,
                  onTap: () {
                    if (isEmergency) {
                      Navigator.pop(context);
                      cubit!.acceptOrDecline("emergency_consultations", id,
                          "approved", "", "", "", selectedStatus, "");
                    } else {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pop(context);
                        cubit!.acceptOrDecline(
                            categoriesModel!.data!.rows![categoryKeyIndex].key
                                .toString(),
                            id,
                            "approved",
                            controller.text,
                            "",
                            "",
                            selectedStatus,
                            answerController.text);
                      }
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  filterDialog() {
    return StatefulBuilder(
      builder: (context, setState) {
        setState(() {
          print(fromDate);
        });
        return Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "by_period".tr,
                  style: TextStyle(fontSize: 15.sp, color: mainColor),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          // setState(() {
                          //   _selectDate(context);
                          // });
                          final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: fromDate,
                              firstDate: DateTime(2015, 8),
                              lastDate: DateTime(2101));
                          if (picked != null && picked != fromDate) {
                            setState(() {
                              fromDate = picked;
                              print(fromDate);
                            });
                          }
                        },
                        child: Column(
                          children: [
                            Text(
                              "from".tr,
                              style: TextStyle(fontSize: 14.sp),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: lightGrey)),
                                padding: EdgeInsets.symmetric(
                                    vertical: 12.h, horizontal: 20.h),
                                child: Text(
                                    fromDate.toString().substring(0, 10),
                                    style: TextStyle(fontSize: 15.sp)))
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      GestureDetector(
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: toDate,
                              firstDate: DateTime(2015, 8),
                              lastDate: DateTime(2101));
                          if (picked != null && picked != toDate) {
                            setState(() {
                              toDate = picked;
                              print(toDate);
                            });
                          }
                        },
                        child: Column(
                          children: [
                            Text(
                              "to".tr,
                              style: TextStyle(fontSize: 14.sp),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: lightGrey)),
                                padding: EdgeInsets.symmetric(
                                    vertical: 12.h, horizontal: 20.h),
                                child: Text(toDate.toString().substring(0, 10),
                                    style: TextStyle(fontSize: 15.sp)))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "by_status".tr,
                  style: TextStyle(fontSize: 15.sp, color: mainColor),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: lightGrey),
                        borderRadius: BorderRadius.circular(30)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        //hint:'',
                        dropdownColor: Colors.white,
                        icon: Padding(
                          padding: EdgeInsetsDirectional.only(start: 30.w),
                          child: Icon(
                            Icons.arrow_drop_down,
                            color: lightGrey,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                        value: selectedStatus,
                        onChanged: (newValue) {
                          setState(() {
                            selectedStatus = newValue!;
                          });
                        },
                        items:
                            status.map<DropdownMenuItem<String>>((valueItem) {
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(
                              valueItem.tr,
                              style: TextStyle(
                                fontSize: 15.sp,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: RoundedYellowButton(
                      text: "filter_results".tr,
                      onTap: () {
                        Navigator.pop(context);
                        cubit!.emit(LogsInitialStates());
                        cubit!.getLogsItems(
                            widget.comeFromMain == true
                                ? widget.categoryKey
                                : categoriesModel!
                                    .data!.rows![categoryKeyIndex].key
                                    .toString(),
                            fromDate.toString().substring(0, 10),
                            toDate.toString().substring(0, 10),
                            selectedStatus);
                      }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: fromDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != fromDate) {
      setState(() {
        fromDate = picked;
        print(fromDate);
      });
      cubit!.emit(LogsInitialStates());
      cubit!.getLogsItems(
          widget.comeFromMain == true
              ? widget.categoryKey
              : categoriesModel!.data!.rows![categoryKeyIndex].key.toString(),
          fromDate.toString().substring(0, 10),
          toDate.toString().substring(0, 10),
          selectedStatus);
    }
  }

  Future<void> _selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: toDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != toDate) {
      setState(() {
        toDate = picked;
        print(toDate);
      });
      cubit!.emit(LogsInitialStates());
      cubit!.getLogsItems(
          widget.comeFromMain == true
              ? widget.categoryKey
              : categoriesModel!.data!.rows![categoryKeyIndex].key.toString(),
          fromDate.toString().substring(0, 10),
          toDate.toString().substring(0, 10),
          selectedStatus);
    }
  }
}

DateTime fromDate = DateTime.now().subtract(Duration(days: 15));
DateTime toDate = DateTime.now().add(Duration(days: 15));
