import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:istchrat/screens/main/widgets/home_header.dart';
import 'package:istchrat/screens/notifications/notifications_screen.dart';
import 'package:istchrat/screens/teacher/teacher_main/cubit/main_teacher_cubit.dart';
import 'package:istchrat/screens/teacher/teacher_main/cubit/main_teacher_state.dart';
import 'package:istchrat/screens/teacher/teacher_main/models/MainTeacherModel.dart';
import 'package:istchrat/screens/teacher/teacher_waiting/teacher_waiting_screen.dart';
import '../../../../main.dart';
import '../../../../shared_components/constants/constants.dart';
import '../../../login/login_screen.dart';
import '../../../notifications/binding/notifications_binding.dart';
import 'teacher_main_item.dart';
import 'package:istchrat/shared_components/colors.dart';

class TeacherMain extends StatefulWidget {
  const TeacherMain({Key? key}) : super(key: key);

  @override
  State<TeacherMain> createState() => _TeacherMainState();
}

class _TeacherMainState extends State<TeacherMain> {
  SnackBar? snackBar;
  late MainTeacherCubit mainTeacherCubit;
  MainTeacherModel? teacher_model = MainTeacherModel();
  bool isLoading = true;
  List<Data>? teacherdata;

  @override
  void customSnackBar(String content, Color color, Duration duration,
      SnackBarAction snackBarAction) {
    snackBar = SnackBar(
      content: Text(content),
      backgroundColor: color,
      duration: duration,
      action: snackBarAction,
    );
    // Timer(Duration(seconds: 1), () {
    //   // _loginController.reset();
    //   ScaffoldMessenger.of(context).showSnackBar(snackBar!);
    // });
    scaffoldKey.currentState!.showSnackBar(snackBar!);
  }

  final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MainTeacherCubit()..getTeacherMainList()..setDeviceToken(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: Container(
                  //width: 200.w,
                  margin: EdgeInsetsDirectional.only(
                      top: 5.h, start: 20.w, end: 15.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if(box.read(Constants.isLogged.toString()) ?? false){
                            Get.to(() => const NotificationsScreen(), binding: NotificationsBinding());
                          }else{
                            Get.to(() => LoginScreen(comeFromHome: true));
                          }
                        },
                        child: SvgPicture.asset(
                          "assets/icons/notification.svg",
                          width: 30.w,
                          height: 30.h,
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Visibility(
                        visible: false,
                        child: SvgPicture.asset(
                          "assets/icons/search.svg",
                          width: 30.w,
                          height: 30.h,
                        ),
                      ),
                    ],
                  ),
                ),
                leadingWidth: 150.w,
              ),
              body: BlocConsumer<MainTeacherCubit, MainTeacherState>(
                listener: (context, state) {
                  if (state is MainTeacherFail) {
                    customSnackBar(
                        "network_error".tr,
                        Colors.red,
                        Duration(days: 1),
                        SnackBarAction(
                            label: "",
                            textColor: Colors.white,
                            onPressed: () {
                              scaffoldKey.currentState!.hideCurrentSnackBar();
                              //ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            }));
                  }
                },
                builder: (context, state) {
                  mainTeacherCubit = MainTeacherCubit.get(context);
                  teacher_model = mainTeacherCubit.teacher_model;
                  isLoading = mainTeacherCubit.isLoading;
                  if (isLoading == false) {
                    teacherdata = teacher_model?.data;
                  }
                  return Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5.h,
                          ),
                          HomeHeader(),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            margin: EdgeInsetsDirectional.only(
                                start: 10.w, end: 10.w),
                            child: Text(
                              "statistics".tr,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: darkBlue,
                              ),
                            ),
                          ),
                          isLoading == true
                              ? const Center(child: CircularProgressIndicator())
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: teacherdata?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                        onTap: () {
                                         /* if (teacherdata![index]
                                                      .categoryKey
                                                      .toString() !=
                                                  "online_courses" &&
                                              teacherdata![index]
                                                      .categoryKey
                                                      .toString() !=
                                                  "offline_courses" &&
                                              teacherdata![index]
                                                      .categoryKey
                                                      .toString() !=
                                                  "books") {
                                            Get.to(() => TeacherWaitingScreen(
                                                title: teacherdata![index]
                                                    .type
                                                    .toString(),
                                                categoryKey: teacherdata![index]
                                                    .categoryKey
                                                    .toString(),
                                                comeFromMain: true));
                                          } */
                                        },
                                        child: TeacherMainItem(
                                          teacherdata: teacherdata![index],
                                        ));
                                  },
                                )
                        ],
                      ),
                    ),
                  );
                },
              )),
        ));
  }
}
