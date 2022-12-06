import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:istchrat/screens/bottom_nav_bar/bottom_nav_bar_screen.dart';
import 'package:istchrat/screens/call/audio_call/audio_call_screen.dart';
import 'package:istchrat/screens/call/video_call/video_call_screen.dart';
import 'package:istchrat/screens/chat/chat_screen.dart';
import 'package:istchrat/screens/dialing/dialing_screen.dart';
import 'package:istchrat/screens/intro/onboarding_screen.dart';
import 'package:istchrat/screens/splash/main_splash_screen.dart';
import 'package:istchrat/screens/teacher/teacher_bottom_nav_bar/teacher_bottom_nav_bar.dart';
import 'package:istchrat/shared_components/bloc_observer/bloc_observer.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:istchrat/shared_components/constants/constants.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';
import 'package:istchrat/shared_components/helper_functions.dart';
import 'package:istchrat/shared_components/localization/localization.dart';
import 'package:permission_handler/permission_handler.dart';

import 'shared_components/widgets/rounded_yellow_button.dart';

final _localNotification = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
    () {},
    blocObserver: MyBlocObserver(),
  );
  await GetStorage.init();
  Bloc.observer = MyBlocObserver();
  DioUtilNew.getInstance();
  await Firebase.initializeApp();
  await _localNotification.initialize(
      InitializationSettings(
        android: const AndroidInitializationSettings('@mipmap/launcher_icon'),
        iOS: IOSInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            onDidReceiveLocalNotification: (int? id, String? title,
                String? body, String? payload) async {}),
      ), onSelectNotification: (String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
      if(box.read(Constants.role.toString()) == "lecturer"){
        Get.offAll(
          TeacherBottomNavBarScreen(
            openWaiting: true,
            index: getLecturerWaitingCategoryIndex(payload),
          ),
        );
      }else{
        Get.offAll(
          BottomNavBarScreen(
            openMyLibrary: true,
            index: getCategoryIndex(payload),
          ),
        );
      }
    }
  });
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

final box = GetStorage();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final _cloudMessaging = FirebaseMessaging.instance;
  RemoteConfig remoteConfig = RemoteConfig.instance;

  _register() {
    _firebaseMessaging.getToken().then((token) => print(token));
  }

  Future<void> disableCapture() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  @override
  void initState() {
    disableCapture();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
    if (box.read(Constants.lang.toString()) != null) {
      lang = box.read(Constants.lang.toString());
    }

    print(lang);
    print(">>>>>>>>>>>");
//    _initializeFlutterFire();
    /* FlutterError.onError = (FlutterErrorDetails errorDetails) async {
      await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    };*/
    getMessage();
    setupRemoteConfig();
    requestCallPermissions();
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
  }

  void setupRemoteConfig() async {
    remoteConfig.setDefaults(<String, dynamic>{
      'welcome_message': 'this is the default welcome message',
      'feat1_enabled': false,
    });

   /* await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: Duration(seconds: 1),
      minimumFetchInterval: Duration(minutes: 5),
    )); */
    await remoteConfig.ensureInitialized();

    await remoteConfig.fetchAndActivate();
    await remoteConfig.fetch();
    await remoteConfig.activate();
    bool isUploading = remoteConfig.getBool("isUploading");
    await box.write('isUploading', isUploading);
    if(isUploading == false){
      await secureIOSScreen();
    }
  }

  Future<void> secureIOSScreen() async{
    if(Platform.isIOS){
      const channel = MethodChannel("secureIOSChannel");
      await channel.invokeMethod('secureScreen').then((_) => print("IOS Screen Secured"));
    }
  }

  void getMessage() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      print(message.data.toString() + "Notifi Data");
      if (message.data['type'] == "start_calling") {
        if (message.data["category_key"] == "chat_consultations") {
          Get.to(
            () => ChatScreen(
              isTeacher: false,
              id: int.tryParse(message.data['id']) ?? 0,
              period: int.tryParse(message.data['period']) ?? 0,
              channelName: message.data['channel_name'],
              image: "${message.data['sender_image']}",
              toUserName: message.data['sender_name'],
            ),
          );
        } else {
          Get.to(() => DialingScreen(
                isVideo: message.data['category_key'] == "video_consultations",
                id: message.data['id'] ?? "",
                pic: "${message.data['sender_image']}",
                period: message.data['period'],
                isLecturer: false,
                name: message.data['sender_name'],
                categoryKey: message.data['category_key'],
                channelName: message.data['channel_name'],
              ));
        }
      } else if (message.data['type'] == "accept_calling") {
        if (message.data['category_key'] == "video_consultations") {
          Get.offAll(() => VideoCallScreen(
                channelName: message.data['channel_name'],
                period: int.tryParse(message.data['period']) ?? 0,
              ));
        } else {
          Get.offAll(() => AudioCallScreen(
                channelName: message.data['channel_name'],
                name: message.data['sender_name'],
                period: int.tryParse(message.data['period']) ?? 0,
                img: "${message.data['sender_image']}",
              ));
        }
      } else if (message.data['type'] == "decline_calling" ||
          message.data['type'] == "end_calling") {
        if (box.read(Constants.role.toString()) == "lecturer") {
          Get.offAll(() => TeacherBottomNavBarScreen());
        } else {
          Get.offAll(() => BottomNavBarScreen());
        }
      } else if (message.data['type'] == "delayed") {
        Get.dialog(
            AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    "consultation_delayed".tr,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "consultation_delayed_description".trParams({
                      "name": "${message.data['sender_name']}",
                      "date": "${message.data['delayed_date']}",
                      "time": "${message.data['delayed_time']}"
                    }),
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 17.sp,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  RoundedYellowButton(
                    onTap: () async {
                      final _dio = DioUtilNew.dio;
                      await DioUtilNew.post(
                          "${getCategoryUrlSegment(message.data['category_key'])}/approveOrDecline/${message.data['id']}",
                          data: {"status": 1}).then((data) {
                        Get.back();
                        if(box.read(Constants.role.toString()) == "lecturer"){
                          Get.offAll(
                            TeacherBottomNavBarScreen(
                              openWaiting: true,
                              index:
                              getLecturerWaitingCategoryIndex(message.data['category_key']),
                            ),
                          );
                        }else{
                          Get.offAll(
                            BottomNavBarScreen(
                              openMyLibrary: true,
                              index:
                              getCategoryIndex(message.data['category_key']),
                            ),
                          );
                        }
                      });
                    },
                    text: "accept".tr,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final _dio = DioUtilNew.dio;
                        await DioUtilNew.post(
                            "${getCategoryUrlSegment(message.data['category_key'])}/approveOrDecline/${message.data['id']}",
                            data: {"status": 2}).then((data) {
                          Get.back();
                          if(box.read(Constants.role.toString()) == "lecturer"){
                            Get.offAll(
                              TeacherBottomNavBarScreen(
                                openWaiting: true,
                                index:
                                getLecturerWaitingCategoryIndex(message.data['category_key']),
                              ),
                            );
                          }else{
                            Get.offAll(
                              BottomNavBarScreen(
                                openMyLibrary: true,
                                index:
                                getCategoryIndex(message.data['category_key']),
                              ),
                            );
                          }
                        });
                      },
                      child: Text(
                        "refuse".tr,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontFamily: 'cairo',
                        ),
                      ),
                      style: ButtonStyle(
                        shadowColor:
                            MaterialStateProperty.all(Colors.transparent),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        elevation: MaterialStateProperty.all(0),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.h),
                            side: BorderSide(
                              color: Colors.black87,
                            ))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            barrierDismissible: false);
      } else {
        print("not data: ${message.data}");
        if (notification != null && android != null) {
          _localNotification.show(
            notification.hashCode,
            notification.title,
            notification.body,
            const NotificationDetails(
              android: AndroidNotificationDetails(
                "Istesharat_CHANNEL_ID",
                "Istesharat",
                //"",
                importance: Importance.high,
                priority: Priority.high,
                playSound: true,
              ),
            ),
            payload: message.data['type'] == message.data['category_key']
                ? message.data['category_key']
                : null,
          );
        }
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // print("OnMessageOpenedApp Called " + event.toString());
      RemoteNotification notification = message.notification!;
      AndroidNotification? android = message.notification!.android;
      print(message.data.toString() + "Notifi Data on opened");
      if (message.data['type'] == "start_calling") {
        if (message.data["category_key"] == "chat_consultations") {
          Get.offAll(
            () => ChatScreen(
              isTeacher: false,
              id: int.tryParse(message.data['id']) ?? 0,
              period: int.tryParse(message.data['period']) ?? 0,
              channelName: message.data['channel_name'],
              image: "${message.data['sender_image']}",
              toUserName: message.data['sender_name'],
            ),
          );
        } else {
          Get.offAll(() => DialingScreen(
                isVideo: message.data['category_key'] == "video_consultations",
                id: message.data['id'] ?? "",
                pic: "${message.data['sender_image']}",
                period: message.data['period'],
                isLecturer: false,
                name: message.data['sender_name'],
                categoryKey: message.data['category_key'],
                channelName: message.data['channel_name'],
              ));
        }
      } else if (message.data['type'] == "accept_calling") {
        FlutterRingtonePlayer.stop();
        if (message.data['category_key'] == "video_consultations") {
          Get.offAll(() => VideoCallScreen(
                channelName: message.data['channel_name'],
                period: int.tryParse(message.data['period']) ?? 0,
              ));
        } else {
          Get.offAll(() => AudioCallScreen(
                channelName: message.data['channel_name'],
                name: message.data['sender_name'],
                period: int.tryParse(message.data['period']) ?? 0,
                img: "${message.data['sender_image']}",
              ));
        }
      } else if (message.data['type'] == "decline_calling" ||
          message.data['type'] == "end_calling") {
        FlutterRingtonePlayer.stop();
        if (box.read(Constants.role.toString()) == "lecturer") {
          Get.offAll(() => TeacherBottomNavBarScreen());
        } else {
          Get.offAll(() => BottomNavBarScreen());
        }
      } else if (message.data['type'] == "delayed") {
        Get.offAll(() => BottomNavBarScreen());
        Get.dialog(
            AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    "consultation_delayed".tr,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "consultation_delayed_description".trParams({
                      "name": "${message.data['sender_name']}",
                      "date": "${message.data['delayed_date']}",
                      "time": "${message.data['delayed_time']}"
                    }),
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 17.sp,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  RoundedYellowButton(
                    onTap: () async {
                      final _dio = DioUtilNew.dio;
                      await DioUtilNew.post(
                          "${getCategoryUrlSegment(message.data['category_key'])}/approveOrDecline/${message.data['id']}",
                          data: {"status": 1}).then((data) {
                        Get.back();
                        if(box.read(Constants.role.toString()) == "lecturer"){
                          Get.offAll(
                            TeacherBottomNavBarScreen(
                              openWaiting: true,
                              index:
                              getLecturerWaitingCategoryIndex(message.data['category_key']),
                            ),
                          );
                        }else{
                          Get.offAll(
                            BottomNavBarScreen(
                              openMyLibrary: true,
                              index:
                              getCategoryIndex(message.data['category_key']),
                            ),
                          );
                        }
                      });
                    },
                    text: "accept".tr,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final _dio = DioUtilNew.dio;
                        await DioUtilNew.post(
                            "${getCategoryUrlSegment(message.data['category_key'])}/approveOrDecline/${message.data['id']}",
                            data: {"status": 2}).then((data) {
                          Get.back();
                          if(box.read(Constants.role.toString()) == "lecturer"){
                            Get.offAll(
                              TeacherBottomNavBarScreen(
                                openWaiting: true,
                                index:
                                getLecturerWaitingCategoryIndex(message.data['category_key']),
                              ),
                            );
                          }else{
                            Get.offAll(
                              BottomNavBarScreen(
                                openMyLibrary: true,
                                index:
                                getCategoryIndex(message.data['category_key']),
                              ),
                            );
                          }
                        });
                      },
                      child: Text(
                        "refuse".tr,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontFamily: 'cairo',
                        ),
                      ),
                      style: ButtonStyle(
                        shadowColor:
                        MaterialStateProperty.all(Colors.transparent),
                        backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                        foregroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                        overlayColor:
                        MaterialStateProperty.all(Colors.transparent),
                        elevation: MaterialStateProperty.all(0),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.h),
                            side: BorderSide(
                              color: Colors.black87,
                            ))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            barrierDismissible: false);
      } else {
        if (message.data['type'] == message.data['category_key'] &&
            box.read(Constants.role.toString()) != "lecturer") {
          Get.offAll(
            BottomNavBarScreen(
              openMyLibrary: true,
              index: getCategoryIndex(message.data['category_key']),
            ),
          );
        }else{
          Get.offAll(
            TeacherBottomNavBarScreen(
              openWaiting: true,
              index: getLecturerWaitingCategoryIndex(message.data['category_key']),
            ),
          );
        }
      }
      /*if (notification != null && android != null) {
        /* showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!,
                    style: TextStyle(
                      fontSize: 15,
                    )),
                content: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notification.body!,
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    )),
              );
            }); */
      } */
    });
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        print(message.data.toString() + "Notifi Data from bg");
        if (message.data['type'] == "start_calling") {
          if (message.data["category_key"] == "chat_consultations") {
            Get.offAll(
                  () => ChatScreen(
                isTeacher: false,
                id: int.tryParse(message.data['id']) ?? 0,
                period: int.tryParse(message.data['period']) ?? 0,
                channelName: message.data['channel_name'],
                image: "${message.data['sender_image']}",
                toUserName: message.data['sender_name'],
              ),
            );
          } else {
            Get.offAll(() => DialingScreen(
              isVideo: message.data['category_key'] == "video_consultations",
              id: message.data['id'] ?? "",
              pic: "${message.data['sender_image']}",
              period: message.data['period'].toString(),
              isLecturer: false,
              name: message.data['sender_name'],
              categoryKey: message.data['category_key'],
              channelName: message.data['channel_name'],
            ));
          }
        } else if (message.data['type'] == "accept_calling") {
          FlutterRingtonePlayer.stop();
          if (message.data['category_key'] == "video_consultations") {
            Get.offAll(() => VideoCallScreen(
              channelName: message.data['channel_name'],
              period: int.tryParse(message.data['period']) ?? 0,
            ));
          } else {
            Get.offAll(() => AudioCallScreen(
              channelName: message.data['channel_name'],
              name: message.data['sender_name'],
              period: int.tryParse(message.data['period']) ?? 0,
              img: "${message.data['sender_image']}",
            ));
          }
        } else if (message.data['type'] == "decline_calling" ||
            message.data['type'] == "end_calling") {
          FlutterRingtonePlayer.stop();
          if (box.read(Constants.role.toString()) == "lecturer") {
            Get.offAll(() => TeacherBottomNavBarScreen());
          } else {
            Get.offAll(() => BottomNavBarScreen());
          }
        } else if (message.data['type'] == "delayed") {
          Get.offAll(() => BottomNavBarScreen());
          Get.dialog(
              AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      "consultation_delayed".tr,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "consultation_delayed_description".trParams({
                        "name": "${message.data['sender_name']}",
                        "date": "${message.data['delayed_date']}",
                        "time": "${message.data['delayed_time']}"
                      }),
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 17.sp,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    RoundedYellowButton(
                      onTap: () async {
                        final _dio = DioUtilNew.dio;
                        await DioUtilNew.post(
                            "${getCategoryUrlSegment(message.data['category_key'])}/approveOrDecline/${message.data['id']}",
                            data: {"status": 1}).then((data) {
                          Get.back();
                          if(box.read(Constants.role.toString()) == "lecturer"){
                            Get.offAll(
                              TeacherBottomNavBarScreen(
                                openWaiting: true,
                                index:
                                getLecturerWaitingCategoryIndex(message.data['category_key']),
                              ),
                            );
                          }else{
                            Get.offAll(
                              BottomNavBarScreen(
                                openMyLibrary: true,
                                index:
                                getCategoryIndex(message.data['category_key']),
                              ),
                            );
                          }
                        });
                      },
                      text: "accept".tr,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          final _dio = DioUtilNew.dio;
                          await DioUtilNew.post(
                              "${getCategoryUrlSegment(message.data['category_key'])}/approveOrDecline/${message.data['id']}",
                              data: {"status": 2}).then((data) {
                            Get.back();
                            if(box.read(Constants.role.toString()) == "lecturer"){
                              Get.offAll(
                                TeacherBottomNavBarScreen(
                                  openWaiting: true,
                                  index:
                                  getLecturerWaitingCategoryIndex(message.data['category_key']),
                                ),
                              );
                            }else{
                              Get.offAll(
                                BottomNavBarScreen(
                                  openMyLibrary: true,
                                  index:
                                  getCategoryIndex(message.data['category_key']),
                                ),
                              );
                            }
                          });
                        },
                        child: Text(
                          "refuse".tr,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontFamily: 'cairo',
                          ),
                        ),
                        style: ButtonStyle(
                          shadowColor:
                          MaterialStateProperty.all(Colors.transparent),
                          backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                          foregroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                          overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                          elevation: MaterialStateProperty.all(0),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.h),
                              side: BorderSide(
                                color: Colors.black87,
                              ))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              barrierDismissible: false);
        } else {
          if (message.data['type'] == message.data['category_key'] &&
              box.read(Constants.role.toString()) != "lecturer") {
            Get.offAll(
              BottomNavBarScreen(
                openMyLibrary: true,
                index: getCategoryIndex(message.data['category_key']),
              ),
            );
          }else{
            Get.offAll(
              TeacherBottomNavBarScreen(
                openWaiting: true,
                index: getLecturerWaitingCategoryIndex(message.data['category_key']),
              ),
            );
          }
        }
      }
    });

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await FirebaseMessaging.instance
        .requestPermission(alert: true, badge: true, sound: true);

    _firebaseMessaging.getToken().then((token) {
      //print("nandhuSaha");
      print(token);
    });
  }

  requestCallPermissions() async{
    await [Permission.camera, Permission.microphone].request();
  }

  String lang = "en";

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return ScreenUtilInit(
        designSize: const Size(412, 870),
        builder: (context, child) => GetMaterialApp(
              debugShowCheckedModeBanner: false,
              translations: Localization(),
              locale: Locale(lang),
              title: "Dr.Mostafa Aboussaad",
              fallbackLocale: Locale("en"),
              // localizationsDelegates: [
              // localizationsDelegates: [
              //AppLocalizations.delegate,
              // GlobalMaterialLocalizations.delegate,
              // GlobalMaterialLocalizations.delegate,
              // GlobalMaterialLocalizations.delegate,
              // GlobalCupertinoLocalizations.delegate,
              // GlobalWidgetsLocalizations.delegate,
              //],*/
              /* supportedLocales: context.supportedLocales,

          //localizationsDelegates: context.localizationDelegates,
          locale: context.locale,
          // locale: Locale('ar'),
          debugShowCheckedModeBanner: false, */
              theme: ThemeData(
                fontFamily: "Tajawal",
                primaryColor: mainColor,
              ),
              home: MainSplashScreen(),
            ));
  }
}
