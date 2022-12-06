import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';
import 'package:istchrat/usecases/buy/model/success_buy.dart';

class BuyUseCase {
  static Future<Either<String, SuccessBuyResponse>> buy(
      {required String type, required String service, required Map<
          String,
          dynamic> map}) async {
    final dio = DioUtilNew.dio!;
    try {
      final response = await DioUtilNew.post('$type/$service', data: map);
      final data = SuccessBuyResponse.fromJson(response.data);
      return Right(data);
    } catch (error) {
      debugPrint(error.toString());
      return const Left("Something went wrong!");
    }
  }
}