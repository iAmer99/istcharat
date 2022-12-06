import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:istchrat/screens/bottom_nav_bar/bottom_nav_bar_screen.dart';
import 'package:istchrat/screens/chat/cubit/chat_cubit.dart';
import 'package:istchrat/screens/chat/cubit/chat_states.dart';
import 'package:istchrat/screens/chat/model/chat_model.dart';
import 'package:istchrat/screens/chat/model/firestore_constants.dart';
import 'package:istchrat/screens/chat/widgets/date_title.dart';
import 'package:istchrat/screens/chat/widgets/received_message.dart';
import 'package:istchrat/screens/chat/widgets/sent_message.dart';
import 'package:istchrat/screens/chat/widgets/type_field.dart';
import 'package:istchrat/screens/teacher/teacher_bottom_nav_bar/teacher_bottom_nav_bar.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:istchrat/shared_components/constants/constants.dart';
import 'package:istchrat/shared_components/widgets/custom_app_bar.dart';

import '../../custom_widgets/custom_dialogs/failed_dialog/failed_dialog.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen(
      {Key? key,
      required this.isTeacher,
      required this.id,
      required this.image,
      this.period = 0,
      this.channelName,
      required this.toUserName})
      : super(key: key);
  final bool isTeacher;
  final int id;
  int period;
  String image;
  String? channelName;
  final String toUserName;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();

  ChatCubit? chatCubit;
  List<QueryDocumentSnapshot> listMessage = [];

  String userID = '';
  int? id;

  final box = GetStorage();
  Timer? countdownTimer;
  late Duration myDuration;
  String minutes = "00";
  String seconds = "00";
  String hours = "00";

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        stopTimer();
        if (box.read(Constants.role.toString()) == "lecturer") {
          Get.offAll(() => TeacherBottomNavBarScreen());
        } else {
          Get.offAll(() => BottomNavBarScreen());
        }
      } else {
        myDuration = Duration(seconds: seconds);
      }
      hours = strDigits(myDuration.inHours.remainder(60));
      minutes = strDigits(myDuration.inMinutes.remainder(60));
      this.seconds = strDigits(myDuration.inSeconds.remainder(60));
    });
  }

  String strDigits(int n) => n.toString().padLeft(2, '0');

  @override
  void initState() {
    super.initState();
    myDuration = Duration(minutes: widget.period);
    if (!widget.isTeacher) startTimer();
    userID = box.read(Constants.email.toString());
    if (widget.isTeacher == false) {
      id = box.read(Constants.id.toString());
    } else {
      id = widget.id;
    }
    print(userID);
    print(id);
  }

  @override
  void dispose() {
    countdownTimer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit()
        ..startChat(id: widget.id.toString(), isLecturer: widget.isTeacher),
      child: BlocConsumer<ChatCubit, ChatStates>(
        listener: (context, state) {
          if (state is ChatStartedState) {
            widget.period = int.parse(state.period);
            myDuration = Duration(minutes: widget.period);
            startTimer();
          } else if (state is ChatFailedState) {
            failedDialog(
                context: context,
                message: state.error,
                onCancel: () {
                  Get.back();
                });
          }
        },
        builder: (context, state) {
          chatCubit = ChatCubit.get(context);
          if (widget.image.isEmpty) widget.image = chatCubit!.img;
          return WillPopScope(
            onWillPop: () async{
              return false;
            },
            child: Scaffold(
              appBar: CustomAppBar.appBar(context, text: "chatMessage".tr, backButton: box.read(Constants.role.toString()) == "lecturer"),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: state is ChatStartingState
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: mainColor,
                        ),
                      )
                    : state is ChatFailedState
                        ? Center(
                            child: Text(
                              state.error,
                              style: TextStyle(
                                color: mainColor,
                                fontSize: 15.sp,
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              DateTitle(
                                  date:
                                      DateTime.now().toString().substring(0, 10)),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  "$hours:$minutes:$seconds",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Expanded(
                                child: StreamBuilder<QuerySnapshot>(
                                    stream: chatCubit!.getChatStream(
                                        widget.channelName ??
                                            chatCubit?.channelName ??
                                            "",
                                        100),
                                    builder: (context, snapShot) {
                                      if (snapShot.hasData) {
                                        listMessage = snapShot.data!.docs;
                                        if (listMessage.length > 0) {
                                          return ListView.builder(
                                            padding: EdgeInsets.all(10),
                                            itemBuilder: (context, index) =>
                                                buildItem(index,
                                                    snapShot.data?.docs[index]),
                                            itemCount: snapShot.data?.docs.length,
                                            reverse: true,
                                            // controller: listScrollController,
                                          );
                                          // return ListView(
                                          //   children:  [
                                          //     SentMessage(message: "Salam Allaykom", time: "2 Mins ago"),
                                          //     ReceivedMessage(
                                          //         message:
                                          //         "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                                          //         time: "2 Mins ago"),
                                          //     SentMessage(message: "Salam Allaykom", time: "2 Mins ago"),
                                          //     ReceivedMessage(
                                          //         message:
                                          //         "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                                          //         time: "2 Mins ago"),
                                          //     SentMessage(message: "Salam Allaykom", time: "2 Mins ago"),
                                          //     ReceivedMessage(message: "sssss", time: "2 Mins ago"),
                                          //     SentMessage(message: "Salam Allaykom", time: "2 Mins ago"),
                                          //   ],
                                          // );
                                        } else {
                                          return Center(
                                              child:
                                                  Text("No message here yet..."));
                                        }
                                      } else {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      }
                                    }),
                              ),
                              TypeField(
                                  controller: messageController,
                                  onTap: () {
                                    onSendMessage(messageController.text, 1);
                                  }),
                            ],
                          ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildItem(int index, DocumentSnapshot? document) {
    if (document != null) {
      MessageChat messageChat = MessageChat.fromDocument(document);
      if (messageChat.idFrom == box.read(Constants.userName.toString())) {
        // Right (my message)
        return Container(
          child: SentMessage(
              message: messageChat.content,
              image: box.read(Constants.avatar.toString()),
              time: DateFormat('dd MMM kk:mm').format(
                  DateTime.fromMillisecondsSinceEpoch(
                      int.parse(messageChat.timestamp)))),
          width: 300.w,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          margin: EdgeInsets.only(
              bottom: isLastMessageRight(index) ? 20 : 10, right: 10),
        );
      } else {
        // Left (peer message)
        return Container(
          child: ReceivedMessage(
              message: messageChat.content,
              image: widget.image,
              time: DateFormat('dd MMM kk:mm').format(
                  DateTime.fromMillisecondsSinceEpoch(
                      int.parse(messageChat.timestamp)))),
          width: 200,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          margin: EdgeInsets.only(left: 10),
        );
      }
    } else {
      return SizedBox.shrink();
    }
  }

  bool isLastMessageLeft(int index) {
    if ((index > 0 &&
            listMessage[index - 1].get(FirestoreConstants.idFrom) ==
                id.toString()) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMessageRight(int index) {
    if ((index > 0 &&
            listMessage[index - 1].get(FirestoreConstants.idFrom) !=
                id.toString()) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  void onSendMessage(String content, int type) {
    if (content.trim().isNotEmpty) {
      chatCubit!.sendMessage(
          messageController.text,
          1,
          widget.channelName ?? chatCubit?.channelName ?? "",
          box.read(Constants.userName.toString()),
          widget.toUserName);
      messageController.clear();
      // listScrollController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      // Fluttertoast.showToast(msg: 'Nothing to send', );
      print("zzzzzzzzzz");
    }
  }
}
