import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:istchrat/screens/confirm_payment/video_confirm_appointment_screen.dart';
import 'package:istchrat/screens/course_confirmation/payment_confirmation_screen.dart';
import 'package:istchrat/screens/course_details/online_details/cubit/online_course_details_cubit.dart';
import 'package:istchrat/screens/course_details/online_details/cubit/online_course_details_state.dart';
import 'package:istchrat/screens/course_details/online_details/models/course_details_model.dart';
import 'package:istchrat/screens/course_details/widgets/course_description.dart';
import 'package:istchrat/screens/course_details/widgets/course_title.dart';
import 'package:istchrat/screens/course_details/widgets/detials_column.dart';
import 'package:istchrat/screens/course_details/widgets/promotional_video_widget.dart';
import 'package:istchrat/screens/course_details/widgets/tutor_name.dart';
import 'package:istchrat/screens/course_details/widgets/videolist/videolist.dart';
import 'package:istchrat/screens/main/cubit/main_cubit.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:istchrat/shared_components/widgets/custom_app_bar.dart';
import 'package:istchrat/shared_components/widgets/rounded_yellow_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../custom_widgets/custom_dialogs/failed_dialog/failed_dialog.dart';
import '../../../custom_widgets/custom_dialogs/success_dialog/custom_success_dialog.dart';
import '../../../custom_widgets/custom_dialogs/success_dialog/success_dialog.dart';
import '../../../main.dart';
import '../../../shared_components/constants/constants.dart';
import '../../../shared_components/helper_functions.dart';
import '../../bottom_nav_bar/bottom_nav_bar_screen.dart';
import '../../login/login_screen.dart';
import 'models/online_details_model.dart';

class OnlineCourseDetailsScreen extends StatefulWidget {
  final int? id;
  final MainCubit? mainCubit;

  const OnlineCourseDetailsScreen({Key? key, @required this.id, this.mainCubit})
      : super(key: key);

  @override
  State<OnlineCourseDetailsScreen> createState() =>
      _OnlineCourseDetailsScreenState();
}

class _OnlineCourseDetailsScreenState extends State<OnlineCourseDetailsScreen> {
  bool _showAppBar = true;
  SnackBar? snackBar;
  late OnlineCourseDetailsCubit onlineCourse_details_Cubit;
  OnlineDetailsdata? onlinedata = new OnlineDetailsdata();
  bool isLoading = true;
  int sold = 0;
  bool isPurchesd = false;
  String title = "",
      body = "",
      date = "",
      duration = "",
      buyIt = "",
      image = "",
      course_link = "",
      lecturer_name = "",
      price = "";

  late var document;

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
  Widget build(BuildContext ctx) {
    return BlocProvider<OnlineCourseDetailsCubit>(
      create: (ctx) =>
          OnlineCourseDetailsCubit()..getOnlineCourseDetails(widget.id!),
      child: BlocConsumer<OnlineCourseDetailsCubit, OnlineCourseDetailsState>(
        builder: (context, state) {
          onlineCourse_details_Cubit = OnlineCourseDetailsCubit.get(context);

          isLoading = onlineCourse_details_Cubit.isLoading;
          if (isLoading == false) {
            onlinedata = onlineCourse_details_Cubit.onlineeDetailsList?.row;
            image = onlinedata?.image ?? "";
            course_link =
                "${onlinedata?.introLink == null ? "" : onlinedata?.introLink}";
            title = onlinedata?.title ?? "";
            body = onlinedata?.body ?? "";
            isPurchesd = onlinedata?.isPurchased ?? false;
            price = onlinedata?.price ?? "";
            date = onlinedata?.date ?? "";
            duration = onlinedata?.period ?? "";
            sold = onlinedata?.sold ?? 0;
            lecturer_name = onlinedata?.lecturer_name ?? "";
            document = parse(parse(body).body?.text).documentElement?.text;
           /* _ytController = YoutubePlayerController(
              params: YoutubePlayerParams(
                showControls: true,
                showFullscreenButton: true,
              ),
            )..onInit = (){
              _ytController.cueVideoById(videoId: getVideoID(course_link),);
            }; */
            // print(document.outerHtml);

            //buyIt=data.
          }
          return Scaffold(
            appBar: _showAppBar
                ? CustomAppBar.appBar(context,
                    text: "course_details".tr,
                    actions: [
                        isLoading
                            ? SizedBox()
                            : onlineCourse_details_Cubit.onlineeDetailsList!
                                            .row!.isFavorite !=
                                        null &&
                                    onlineCourse_details_Cubit
                                        .onlineeDetailsList!.row!.isFavorite!
                                ? IconButton(
                                    onPressed: () {
                                      onlineCourse_details_Cubit
                                          .removeOnlineCourseToFav(
                                              widget.id.toString());
                                      if(widget.mainCubit != null){
                                        widget.mainCubit!.getHomeData();
                                      }
                                    },
                                    icon: SvgPicture.asset(
                                        'assets/icons/star_colored.svg',
                                        color: yelloCollor),
                                  )
                                : IconButton(
                                    onPressed: () {
                                      onlineCourse_details_Cubit
                                          .addOnlineCourseToFav(
                                              widget.id.toString());
                                      if(widget.mainCubit != null){
                                        widget.mainCubit!.getHomeData();
                                      }
                                    },
                                    icon: SvgPicture.asset(
                                      'assets/icons/starbroken.svg',
                                      width: 20.w,
                                    )),
                      ])
                : null,
            body: ModalProgressHUD(
              inAsyncCall: state is OnlineCourseBuyLoadingState,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: _showAppBar ? 20.w : 0),
                child: isLoading == true
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
// <<<<<<< HEAD
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           PromotionalVideoWidget(image: "${image}"),
//                           SizedBox(
//                             height: 15.h,
//                           ),
//                           CourseTitle(title: "${title}"),
//                           SizedBox(
//                             height: 15.h,
//                           ),
//                           TutorName(name: "${lecturer_name}"),
//                           SizedBox(
//                             height: 15.h,
//                           ),
//                           CourseDescription(
//                               description: "${document.toString()}"),
//                           SizedBox(
//                             height: 25.h,
//                           ),
//                           Row(
//                             children: [
//                               DetailsColumn(title: "buy_it".tr, data: "100"),
//                               SizedBox(
//                                 width: 80.w,
//                               ),
//                               DetailsColumn(
//                                   title: "course_duration".tr,
//                                   data: "${duration}" + " " + "hours"),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 25.h,
//                           ),
//                           Row(
//                             children: [
//                               DetailsColumn(
//                                   title: "course_date".tr,
//                                   data: "${date.toString()}"),
//                               SizedBox(
//                                 width: 80.w,
//                               ),
//                               DetailsColumn(
//                                   title: "last_update".tr,
//                                   data: "${date.toString()}"),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 50.h,
//                           ),
//                           RoundedYellowButton(
//                               text: "Buy course | '  ${price}' "
//                                   " '  ${onlinedata!.currency}' ",
//                               onTap: () {
//                                 Get.to(() => VideoConfirmAppointmentScreen(
//                                     title: "buy_recorded_course".tr));
//                               }),
//                           SizedBox(
//                             height: 15.h,
//                           ),
//                         ],
//                       ),
//               );
//             },
//             listener: (ctx, state) {
//               if (state is OnlineCourseDetailsError) {
//                 customSnackBar(
//                     "network_error".tr,
//                     Colors.red,
//                     Duration(days: 1),
//                     SnackBarAction(
//                         label: "",
//                         textColor: Colors.white,
//                         onPressed: () {
//                           scaffoldKey.currentState!.hideCurrentSnackBar();
//                           //ScaffoldMessenger.of(context).hideCurrentSnackBar();
//                         }));
//               }
//             },
//           )),
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: _showAppBar ? null : Get.height,
                            child: PromotionalVideoWidget(
                              onFullScreenToggle: (bool value){
                                setState(() {
                                  _showAppBar = value;
                                });
                              },
                              course_link:
                                  "${course_link != null || course_link != "" ? course_link : image}",
                              isVideo: course_link.isNotEmpty,
                            ),
                          ),
                          if(_showAppBar) Expanded(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15.h,
                                ),
                                CourseTitle(title: "${title}"),
                                SizedBox(
                                  height: 15.h,
                                ),
                                TutorName(name: "${lecturer_name}"),
                                SizedBox(
                                  height: 15.h,
                                ),
                                CourseDescription(
                                    description: "${document.toString()}"),
                                if(document.toString().isNotEmpty) SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "price".tr,
                                      style: TextStyle(
                                          color: darkBlue,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      ": ${price} ${onlinedata?.currency ?? "USD"}",
                                      style: TextStyle(
                                          color: darkGrey,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 25.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        DetailsColumn(
                                            title: "buy_it".tr, data: "${sold}"),
                                        SizedBox(
                                          height: 25.h,
                                        ),
                                        DetailsColumn(
                                            title: "course_date".tr,
                                            data: "${date.toString()}"),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        DetailsColumn(
                                            title: "course_duration".tr,
                                            data: "${duration}"),
                                        SizedBox(
                                          height: 25.h,
                                        ),
                                        DetailsColumn(
                                            title: "last_update".tr,
                                            data: "${date.toString()}"),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 50.h,
                                ),
                                RoundedYellowButton(
                                    text: isPurchesd == false
                                        ? price == "0" ||
                                        price == "0.0" ||
                                        price == "0.00"
                                        ? "add_to_library".tr
                                        : "buy_course".tr
                                        : "watch".tr,
                                    onTap: () {
                                      if (isPurchesd == false) {
                                        final isLogged =
                                            box.read(Constants.isLogged.toString()) ??
                                                false;
                                        if (isLogged) {
                                          if (price == "0" ||
                                              price == "0.0" ||
                                              price == "0.00") {
                                            onlineCourse_details_Cubit
                                                .addCourseToLibrary(
                                                widget.id.toString());
                                          } else {
                                            onlineCourse_details_Cubit
                                                .buyCourse(widget.id.toString());
                                          }
                                        } else {
                                          successDialog(
                                            context: context,
                                            buttonTitle: "login".tr,
                                            message: "you_should_login_first".tr,
                                            onTap: () {
                                              Navigator.pop(context);
                                              Get.to(() => LoginScreen(
                                                comeFromHome: true,
                                              ));
                                            },
                                          );
                                        }
                                      } else {
                                        Get.to(VideoList(
                                          name: lecturer_name,
                                          title: title,
                                          type: "onlineCourses",
                                          id: widget.id!.toString(),
                                        ));
                                      }
                                    }),
                                SizedBox(
                                  height: 15.h,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
              ),
            ),
          );
        },
        listener: (ctx, state) {
          if (state is OnlineCourseDetailsError) {
            failedDialog(context: context, message: state.error);
          } else if (state is OnlineCourseBuyErrorState) {
            failedDialog(context: context, message: state.error);
          } else if (state is OnlineCourseBuySuccessState) {
            Get.to(() => PaymentConfirmation(
                  title: "buy_recorded_course".tr,
                  id: state.id,
                  itemId: '${widget.id ?? ""}',
                  type: "onlineCourses",
                ));
          } else if (state is OnlineCourseFreeBuySuccessState) {
            Get.defaultDialog(
              title: "",
              content: CustomSuccessDialog(
                message: state.message,
                onTap: (){
                  Get.offAll(BottomNavBarScreen(openMyLibrary: true, index: getCategoryIndex("onlineCourses"),),);
                },
              ),
            );
          }
        },
      ),
    );
  }
}
