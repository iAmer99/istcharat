import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../shared_components/dio_helper/dio_util_new.dart';

class AddNotesUseCase {
  static final Dio _dio = DioUtilNew.dio!;
  static Future<Map<String, dynamic>> addNotesUseCase(
      {required String note, required String id, required String key}) async{
    try{
      final response = await DioUtilNew.post("logs/addReply/$id?category_key=$key", data: {
        "reply" : note,
      });
      print(response.statusCode);
      print(response.data.toString());
      return {
        "status_code" : response.statusCode,
        "message" : response.data["data"]["message"]
      };
    }catch(error){
      debugPrint(error.toString());
      return {
        "status_code" : 500,
        "message" : "unknown_error".tr
      };
    }
  }
}