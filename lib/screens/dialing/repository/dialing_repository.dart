import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:istchrat/screens/dialing/repository/model/StartCallResponse.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';

import '../../../shared_components/helper_functions.dart';

class DialingRepository {
  final Dio _dio = DioUtilNew.dio!;

  Future<Either<String, StartCallResponse>> startCall(
      {required String id, required String key}) async {
    try {
      final response = await DioUtilNew.post('logs/startCall/$id?category_key=$key');
      print(response.data.toString() + "test");
      print(response.statusCode.toString() + " test status code");
      final data = StartCallResponse.fromJson(response.data);
      if(response.statusCode == 200){
        return Right(data);
      }else{
        return Left(response.data['data']['message'] ?? "Call Failed");
      }
    } catch (error) {
      if (error is DioError) {
        return Left(DioUtilNew.handleDioError(error));
      } else {
        debugPrint(error.toString());
        return const Left("Something went wrong!");
      }
    }
  }

  Future endCall({required String id, required String key}) async{
    try{
      final response = await DioUtilNew.post("logs/endCall/$id?category_key=$key");
      if(response.statusCode == 200){
        return true;
      }else{
        return false;
      }
    }catch(error){
      debugPrint(error.toString());
      return false;
    }
  }

  Future acceptOrCancel(
      {required String id, required String key, required String status}) async {
    try {
      final response = await DioUtilNew.post(
          "${getCategoryUrlSegment(key)}/acceptOrDeclineCall/$id",
          data: {
            "status" : status,
          });
      print(response.data.toString());
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      debugPrint(error.toString());
      return false;
    }
  }
}
