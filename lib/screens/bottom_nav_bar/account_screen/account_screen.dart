import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/about/about_screen.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/account_notifications/account_notifications_screen.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/change_password/change_password_screen.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/contact_us/contact_us_screen.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/edit_account_information/edit_account_information.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/questions_and_answers/questions/questions_screen.dart';
import 'package:istchrat/screens/intro/onboarding_screen.dart';
import 'package:istchrat/screens/login/login_screen.dart';
import 'package:istchrat/screens/sign_up/sign_up_screen.dart';
import 'package:istchrat/screens/wallet/binding/wallet_binding.dart';
import 'package:istchrat/screens/wallet/wallet_screen.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:istchrat/shared_components/constants/constants.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';
import 'package:istchrat/shared_components/widgets/rounded_yellow_button.dart';
import 'package:istchrat/usecases/change_language.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../custom_widgets/custom_dialogs/failed_dialog/failed_dialog.dart';
import '../../../main.dart';
import '../bottom_nav_bar_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String? userName;
  String? mobile;
  String? avatar;
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    userName = box.read(Constants.userName.toString());
    avatar = box.read(Constants.avatar.toString());
    // mobile = box.read(Constants..toString());
    print(userName);
    print(avatar);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .15,
              width: double.infinity,
              color: Color(0xffFAFAFA),
              child: Center(
                  child: Text(
                "my_account".tr,
                style: TextStyle(fontSize: 15.sp),
              )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: avatar != null
                        ? Image.network(
                            "${avatar}",
                            height: 60,
                            width: 60,
                            errorBuilder: (context, _, d) => Image.asset(
                              "assets/images/user.png",
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Image.asset(
                            "assets/images/user.png",
                            height: 60,
                            width: 60,
                          ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName != null ? "${userName}" : "",
                        style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                            color: darkGrey),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        "",
                        style: TextStyle(fontSize: 12.sp, color: darkGrey),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
              child: Text(
                "my_account".tr,
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: yelloCollor),
              ),
            ),
           if(!(box.read('isUploading') &&  Platform.isIOS)) Visibility(
              visible: box.read(Constants.role.toString()) != "lecturer",
              child: customRow(
                  title: "Wallet".tr,
                  icon: const Icon(Icons.account_balance_wallet_outlined),
                  hasIcon: true,
                  onPress: () {
                    userName == null
                        ? userNotLoginDialog(context)
                        : Get.to(() => const WalletScreen(),
                            binding: WalletBinding());
                  }),
            ),
            Visibility(
              visible: box.read(Constants.role.toString()) != "lecturer",
              child: customRow(
                  title: "question_and_answer".tr,
                  image: "assets/icons/message-question.svg",
                  onPress: () {
                    userName == null
                        ? userNotLoginDialog(context)
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QuestionsScreen()));
                  }),
            ),
            customRow(
                title: "notifications_settings".tr,
                image: "assets/icons/notification.svg",
                onPress: () {
                  userName == null
                      ? userNotLoginDialog(context)
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AccountNotificationsScreen()));
                }),
            customRow(
                title: "edit_account_information".tr,
                image: "assets/icons/edit.svg",
                onPress: () {
                  userName == null
                      ? userNotLoginDialog(context)
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditAccountInformation()));
                  // _selectDate(context);
                }),
            customRow(
                title: "change_password".tr,
                image: "assets/icons/key.svg",
                onPress: () {
                  userName == null
                      ? userNotLoginDialog(context)
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangePasswordScreen()));
                }),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                    onTap: () async{
                      if (box.read(Constants.lang.toString()) == null ||
                          box.read(Constants.lang.toString()) == "en") {
                        Get.updateLocale(Locale("ar"));
                        box.write(Constants.lang.toString(), "ar");
                        DioUtilNew.setDioAgain();
                        await ChangeLanguageUseCase.change("ar");
                      } else {
                        Get.updateLocale(Locale("en"));
                        box.write(Constants.lang.toString(), "en");
                        DioUtilNew.setDioAgain();
                        await ChangeLanguageUseCase.change("en");
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child:
                                  SvgPicture.asset("assets/icons/global.svg"),
                            ),
                            Text(
                              "change_lang".tr,
                              style:
                                  TextStyle(fontSize: 15.sp, color: darkGrey),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            "lang".tr,
                            style: TextStyle(fontSize: 15.sp, color: grey),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Container(
                    height: 1,
                    width: double.infinity,
                    color: lightGrey,
                  ),
                )
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
              child: Text(
                "support".tr,
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: yelloCollor),
              ),
            ),
            customRow(
                onPress: () {
                  // Get.to(()=>AboutScreen(type: "help",title:"help".tr ,));
                  Get.to(() => ContactUsScreen());
                },
                title: "help".tr,
                image: "assets/icons/eye-security-user.svg"),
            customRow(
                onPress: () {
                  Get.to(() => AboutScreen(
                        type: "about",
                        title: "about_app".tr,
                      ));
                },
                title: "about_app".tr,
                image: "assets/icons/info-circle.svg"),
            customRow(
                onPress: () async {
                  contactViaWhatsApp();
                },
                title: "contact_us".tr,
                hasIcon: true,
                icon: Icon(Icons.whatsapp),
                image: "assets/icons/info-circle.svg"),
            Visibility(
              visible: false,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {},
                    child: Container(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 10),
                                  child: Text(
                                    "Contact with",
                                    style: TextStyle(
                                        fontSize: 15.sp, color: darkGrey),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Icon(Icons.whatsapp),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Container(
                      height: 1,
                      width: double.infinity,
                      color: lightGrey,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
              child: RoundedYellowButton(
                onTap: () {
                  if (userName == null) {
                    Get.to(() => LoginScreen(comeFromHome: false));
                  } else {
                    box.remove(Constants.accessToken.toString());
                    box.write(Constants.isLogged.toString(), false);
                    box.remove(Constants.email.toString());
                    box.remove(Constants.userName.toString());
                    box.remove(Constants.avatar.toString());
                    box.remove(Constants.role.toString());
                    box.write("has_opened", false);
                    Get.offAll(() => OnBoardingScreen());
                  }
                },
                text: userName == null ? "login".tr : "logout".tr,
              ),
            ),
            /* Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    box.remove(Constants.accessToken.toString());
                    box.write(Constants.isLogged.toString(), false);
                    box.remove(Constants.email.toString());
                    box.remove(Constants.userName.toString());
                    box.remove(Constants.avatar.toString());
                    if(userName == null){
                      Get.to(() => LoginScreen(comeFromHome: false));
                    }else{
                      Get.offAll(() => BottomNavBarScreen());
                    }
                  },
                  child: Text(
                    userName == null ? "login".tr : "logout".tr,
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: redColor),
                  ),
                ),
              ),
            ), */
          ],
        ),
      ),
    ));
  }

  customRow({
    String? image,
    String? title,
    Function()? onPress,
    bool hasIcon = false,
    Widget? icon,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (onPress != null) {
              onPress();
            }
          },
          child: Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: hasIcon ? icon : SvgPicture.asset(image!),
                      ),
                      Text(
                        title!,
                        style: TextStyle(fontSize: 15.sp, color: darkGrey),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 20.h,
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Container(
            height: 1,
            width: double.infinity,
            color: lightGrey,
          ),
        ),
      ],
    );
  }

  Widget? userNotLoginDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(30)),
              height: 300.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset("assets/images/avatar1.png"),
                  Text("you_should_login_first".tr),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: RoundedYellowButton(
                        text: "login".tr,
                        onTap: () {
                          Get.to(() => LoginScreen(
                                comeFromHome: false,
                              ));
                        }),
                  ),
                ],
              ),
            ),
          );
        });
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        print(selectedDate);
      });
    }
  }

  contactViaWhatsApp() async{
    var whatsapp ="+96566356900";
    var whatsappURl_android = "whatsapp://send?phone="+whatsapp;
    var whatappURL_ios ="https://wa.me/$whatsapp";
    if(Platform.isIOS){
      if( await canLaunchUrl(Uri.parse(whatappURL_ios))){
        await launch(whatappURL_ios, forceSafariVC: false);
      }else{
        failedDialog(
          context: context,
          message: "download_wtsapp".tr,
        );
      }

    }else{
      // android , web
      if( await canLaunchUrl(Uri.parse(whatsappURl_android))){
        await launchUrl(Uri.parse(whatsappURl_android));
      }else{
        failedDialog(
          context: context,
          message: "download_wtsapp".tr,
        );
      }


    }

  }
}
