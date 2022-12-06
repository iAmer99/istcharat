import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:istchrat/screens/confirm_payment/video_confirm_appointment_screen.dart';
import 'package:istchrat/screens/course_details/cubit/course_details_cubit.dart';
import 'package:istchrat/screens/course_details/cubit/course_details_state.dart';
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

import '../../custom_widgets/custom_dialogs/failed_dialog/failed_dialog.dart';
import '../../custom_widgets/custom_dialogs/success_dialog/custom_success_dialog.dart';
import '../../custom_widgets/custom_dialogs/success_dialog/success_dialog.dart';
import '../../main.dart';
import '../../shared_components/constants/constants.dart';
import '../../shared_components/helper_functions.dart';
import '../bottom_nav_bar/bottom_nav_bar_screen.dart';
import '../course_confirmation/payment_confirmation_screen.dart';
import '../login/login_screen.dart';
import 'models/course_details_model.dart';

class CourseDetailsScreen extends StatefulWidget {
  final int? id;
  final MainCubit? mainCubit;

  const CourseDetailsScreen({Key? key, @required this.id, this.mainCubit}) : super(key: key);

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  bool _showAppBar = true;
  SnackBar? snackBar;
  late CourseDetailsCubit course_details_Cubit;
  CourseDetail? data = new CourseDetail();
  bool isPurchased = false;
  bool isLoading = true;
  int sold = 0;
  String title = "",
      body = "",
      date = "",
      duration = "",
      buyIt = "",
      price = "",
      course_link = "",
      lecturer_name = "";
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
    scaffoldKey.currentState?.showSnackBar(snackBar!);
  }

  final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CourseDetailsCubit()..getOfflineCourseDetails(widget.id!),
      child: BlocConsumer<CourseDetailsCubit, CourseDetailsState>(
        builder: (context, state) {
          course_details_Cubit = CourseDetailsCubit.get(context);

          isLoading = course_details_Cubit.isLoading;
          if (isLoading == false) {
            data = course_details_Cubit.offlineDetailsList?.row;
            title = data?.title ?? "";
            body = data?.body ?? "";
            isPurchased = data?.isPurchased ?? false;
            course_link = "${data?.introLink == null ? "" : data?.introLink}";
            price = data?.price ?? "";
            date = data?.date ?? "";
            duration = data?.period ?? "";
            lecturer_name = data?.lecturer_name ?? "";
            sold = data?.sold ?? 0;
            // print("mmmmmmmmm"+""+lecturer_name);
            document = parse(parse(body).body?.text).documentElement?.text;
            /*if (data!.introLink != null && course_link.isNotEmpty) {
              _ytController = YoutubePlayerController(
                params: YoutubePlayerParams(
                  showControls: true,
                  showFullscreenButton: true,
                ),
              )..onInit = (){
                _ytController.cueVideoById(videoId: course_link.isEmpty
                    ? ""
                    : getVideoID(course_link));
              };
            } else {
              _ytController = YoutubePlayerController();
            } */
            // print(document.outerHtml);

// <<<<<<< HEAD
//                 //buyIt=data.
//               }
//               return Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20.w),
//                 child: isLoading == true
//                     ? Center(child: CircularProgressIndicator())
//                     : Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           PromotionalVideoWidget(image: data!.image),
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
//                                   " '  ${data!.currency}' ",
//                               onTap: () {
//                                 Get.to(() => VideoConfirmAppointmentScreen(
//                                     title: "buy_recorded_course".tr));
//                               }),
//                           SizedBox(
//                             height: 25.h,
//                           ),
//                         ],
// =======
            //buyIt=data.
          }
          return Scaffold(
            appBar: !isLoading && !_showAppBar
                ? null
                : CustomAppBar.appBar(context,
                    text: "course_details".tr,
                    actions: [
                        isLoading
                            ? SizedBox()
                            : course_details_Cubit.offlineDetailsList!.row!
                                            .isFavorite !=
                                        null &&
                                    course_details_Cubit
                                        .offlineDetailsList!.row!.isFavorite!
                                ? IconButton(
                                    onPressed: () {
                                      course_details_Cubit
                                          .removeRecordedCourseFromFav(
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
                                      course_details_Cubit
                                          .addRecordedCourseToFav(
                                              widget.id.toString());
                                      if(widget.mainCubit != null){
                                        widget.mainCubit!.getHomeData();
                                      }
                                    },
                                    icon: SvgPicture.asset(
                                      'assets/icons/starbroken.svg',
                                      width: 20.w,
                                    )),
                      ]),
            body: isLoading == true
                ? Center(child: CircularProgressIndicator())
                : ModalProgressHUD(
                    inAsyncCall: state is BuyLoadingState,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: _showAppBar ? 20.w : 0),
                      child: Column(
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
                                  data!.introLink == null || data!.introLink == ""
                                      ? data!.image
                                      : data!.introLink,
                              isVideo: data!.introLink != null &&
                                  course_link.isNotEmpty,
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
                                     ": ${price} ${data?.currency ?? "USD"}",
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
                                   text: isPurchased == true
                                       ? "watch".tr
                                       : price == "0" ||
                                       price == "0.0" ||
                                       price == "0.00"
                                       ? "add_to_library".tr
                                       : 'buy_course'.tr,
                                   onTap: () {
                                     if (isPurchased == false) {
                                       final isLogged =
                                           box.read(Constants.isLogged.toString()) ??
                                               false;
                                       if (isLogged) {
                                         if(price == "0" ||
                                             price == "0.0" ||
                                             price == "0.00"){
                                           course_details_Cubit.addCourseToLibrary(widget.id.toString());
                                         }else{
                                           course_details_Cubit
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
                                         type: "offlineCourses",
                                         id: widget.id!.toString(),
                                       ));
                                     }
                                   }),
                               SizedBox(
                                 height: 25.h,
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
        listener: (context, state) {
          if (state is CourseDetailsError) {
            failedDialog(context: context, message: state.error);
          }else if(state is BuyErrorState){
            failedDialog(context: context, message: state.error);
          } else if (state is BuySuccessState) {
            Get.to(() => PaymentConfirmation(
                  title: "buy_recorded_course".tr,
                  id: state.id,
                  itemId: "${widget.id ?? ""}",
                  type: "offlineCourses",
                ));
          }else if( state is FreeBuySuccessState){
            Get.defaultDialog(
              title: "",
              content: CustomSuccessDialog(
                message: state.message,
                onTap: (){
                  Get.offAll(BottomNavBarScreen(openMyLibrary: true, index: getCategoryIndex("offlineCourses"),),);
                },
              ),
            );
          }
        },
      ),
    );
  }
}
