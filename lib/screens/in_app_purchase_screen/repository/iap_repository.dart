import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:istchrat/main.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';

import '../../../shared_components/constants/constants.dart';

class IAPRepository {
  final Dio _dio = DioUtilNew.dio!;

  Future<Either<String, bool>> buyItem({required String id, required String type}) async {
    try {
      final userID = box.read(Constants.id.toString()).toString();
      _dio.options.baseUrl = "https://api.mynurserykw.com/api/";
      debugPrint("url is " + _dio.options.baseUrl+"buyNow/$userID");
      debugPrint({
        "model_type": type,
        if (type == "book_sales") "book_id": id,
        if (type == "offline_course_attendances")
          "course_id": id,
        if(type == "online_course_attendances") "course_id" : id,
      }.toString());
      final response = await _dio.post("buyNow/$userID", data: {
        "model_type": type,
        if (type == "book_sales") "book_id": id,
        if (type == "offline_course_attendances")
          "course_id": id,
        if(type == "online_course_attendances") "course_id" : id,
      });
      _dio.options.baseUrl = "https://api.mynurserykw.com/api/v1/";
      debugPrint(response.data.toString());
      if(response.statusCode == 200){
        return Right(true);
      }else{
        return Left("unknown_error".tr);
      }
    } catch (error) {
      debugPrint(error.toString());
      return Left("unknown_error".tr);
    }
  }
}
