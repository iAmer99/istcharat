
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:istchrat/screens/bottom_nav_bar/my_library_screen/repository/model/OldConsultationDataModel.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';

class MyLibraryRepository {
  final Dio _dio = DioUtilNew.dio!;

  Future<Either<String, OldConsultationDataModel>> getData(String type) async{
    try{
      final response = await DioUtilNew.get('$type/myAppointments');
      print(response.data);
      final data = OldConsultationDataModel.fromJson(response.data);
      return Right(data);
    }catch(error){
      if(error is DioError){
        if(error.type == DioErrorType.response){
          return Left(error.response?.data['data']['message'] ?? "unknown_error".tr);
        }
      }
      return Left("unknown_error".tr);
    }
  }
}