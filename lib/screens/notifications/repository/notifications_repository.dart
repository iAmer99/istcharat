import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:istchrat/screens/notifications/repository/model/NotificationsResponse.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';

class NotificationsRepository {
  final Dio _dio = DioUtilNew.dio!;
  
  Future<Either<String, NotificationsResponse>> getNotifications(
      {int? paginatePage}) async{
    try{
      final response = await DioUtilNew.get("notifications", queryParameters: {
        "page" : paginatePage ?? 1,
        "paginate" : "10"
      });
      print(response.data);
      final data = NotificationsResponse.fromJson(response.data);
      print(data.data?.paginate?.currentPage);
      return Right(data);
    }catch(error){
      debugPrint(error.toString());
      return const Left("Something went wrong!");
    }
  }
}