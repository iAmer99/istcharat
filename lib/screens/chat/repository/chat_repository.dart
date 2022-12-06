import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:istchrat/screens/chat/repository/model/StartChatResponse.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';


class ChatRepository {
  final Dio _dio = DioUtilNew.dio!;

  Future<Either<String, StartChatResponse>> startChat(
      {required String id, required String key}) async {
    try {
      final response = await DioUtilNew.post('logs/startCall/$id?category_key=$key');
      final data = StartChatResponse.fromJson(response.data);
      if(response.statusCode == 200){
        return Right(data);
      }else{
        return Left(response.data['data']['message'] ?? "Chat Failed");
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
}