import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:istchrat/screens/bottom_nav_bar/favourite_screen/repository/models/favourite_model.dart';
import 'package:istchrat/screens/login/login_screen.dart';
import 'package:istchrat/shared_components/constants/constants.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';

class FavouritesRepository {
  final _dio = DioUtilNew.dio;
  final box = GetStorage();
  Future<Either<String, FavouriteModel?>> getFavouriteData(
      {required String urlSegment}) async {
    try {
      final response = await DioUtilNew.get("favorites/$urlSegment?paginate=1000");
      print(response.data.toString() + "data");
      if (response.statusCode == 401) {
        return Left(response.data['message']);
        // Get.to(LoginScreen());
      } else {
        final data = FavouriteModel.fromJson(response.data);
        return Right(data);
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
