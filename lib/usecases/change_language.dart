import 'package:dio/dio.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';


class ChangeLanguageUseCase {
  static final Dio _dio = DioUtilNew.dio!;

  static Future change(String lang) async{
    return DioUtilNew.post("auth/locale",
      data: {
        "locale": lang,
      },
    );
  }
}