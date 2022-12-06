import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:istchrat/main.dart';
import 'package:istchrat/screens/bottom_nav_bar/bottom_nav_bar_screen.dart';
import 'package:istchrat/screens/login/login_screen.dart';
import 'package:istchrat/shared_components/constants/constants.dart';
import 'package:get/get.dart' as getx;


class DioUtilNew {

  static DioUtilNew? _instance;
  static late Dio _dio;


  static DioUtilNew? getInstance() {
    if (_instance == null) {
      _dio = Dio(_getOptions());
    }
    return _instance;
  }

  static Dio? get dio => _dio;

  static void setDioAgain() {
    _dio = Dio(_getOptions());
  }

  static BaseOptions _getOptions() {
    BaseOptions options = BaseOptions(
      followRedirects: false,
      validateStatus: (status) => status! <= 500,
    );
    options.connectTimeout = 20 * 1000; //10 sec
    options.receiveTimeout = 20 * 1000; //20 sec
      options.baseUrl = "https://api.mynurserykw.com/api/v1/";
    options.headers = {
      'locale': "${box.read(Constants.lang.toString()) == null ? "en" : box.read(Constants.lang.toString()) }",
      "appid" : "VYi\$upl88HQPy5s02",
      'Authorization': "Bearer ${box.read(Constants.accessToken.toString())}"
      // 'Authorization': "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYXBpLWlzdGNocmF0Lm1hemFkYWsubmV0XC9hcGlcL3YxXC9hdXRoXC9sb2dpbiIsImlhdCI6MTY0NjkwNTE0NiwiZXhwIjoxNjUwNTA1MTQ2LCJuYmYiOjE2NDY5MDUxNDYsImp0aSI6InpHUm5mNzVPYUdIaG9rd2wiLCJzdWIiOjMsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.JNbMo91I1l9NeKQliAeec51yZqeNtCl6KeKkJ25WHqo"
    };
    options.queryParameters = {


    };

    return options;
  }

  //this just returns the language key
  static String handleDioError(DioError dioError) {
    String errorDescription = "";
    switch (dioError.type) {
      case DioErrorType.cancel:
        errorDescription = "request_cancelled";
        break;
      case DioErrorType.connectTimeout:
        //Connection timeout with API server
        errorDescription = "timeout";
        break;
      case DioErrorType.other:
        errorDescription = "checkout_internet";
        break;
      case DioErrorType.receiveTimeout:
        errorDescription = "timeout";
        break;
      case DioErrorType.response:
        print("Received invalid status code: ${dioError.response!.statusCode}");
        errorDescription = "unknown_error";
        break;
      case DioErrorType.sendTimeout:
        errorDescription = "timeout";
        break;
    }
    return errorDescription;
  }

  static Future<Either<String, dynamic>> doNetworkRequest(
    Future<dynamic> request,
  ) async {
    try {
      final result = await request;
      return Right(result);
    } on DioError catch (e) {
      return Left(DioUtilNew.handleDioError(e));
    }
  }

  static Future<Response> post(
      String path, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
        bool isLogin = false,
      }) async {
    print("path is : $path");
    print("sent data : $data");
    final response = await _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
    );
    if (response.statusCode == 401 && !isLogin) {
      print("401 Code + ${response.data}");
      box.remove(Constants.accessToken.toString());
      box.write(Constants.isLogged.toString(), false);
      box.write("has_opened", true);
      box.remove(Constants.email.toString());
      box.remove(Constants.userName.toString());
      box.remove(Constants.avatar.toString());
      getx.Get.offAll(() => BottomNavBarScreen());
      getx.Get.to(() => LoginScreen(comeFromHome: false));
    }else{
      print("0 Code + ${response.data}");
    }
    return response;
  }

  static Future<Response> get(
      String path, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
        bool isLogin = false,
      }) async {
    final response = await _dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
    if (response.statusCode == 401 && !isLogin) {
      box.remove(Constants.accessToken.toString());
      box.write(Constants.isLogged.toString(), false);
      box.write("has_opened", true);
      box.remove(Constants.email.toString());
      box.remove(Constants.userName.toString());
      box.remove(Constants.avatar.toString());
      getx.Get.offAll(() => BottomNavBarScreen());
      getx.Get.to(() => LoginScreen(comeFromHome: false));
    }
    return response;
  }
}
