import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:istchrat/screens/course_confirmation/repo/models/ConfirmBuyingResponse.dart';
import 'package:istchrat/screens/course_confirmation/repo/models/book_details_reponse.dart';
import 'package:istchrat/screens/course_confirmation/repo/models/course_details_response.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';

import '../../confirm_payment/confirm_reservation_repo/ConfirmReservationModel.dart';

class ConfirmationRepository {
  final dio = DioUtilNew.dio!;

  Future<Either<String, CourseDetailsResponse>> getCourseDetails(
      {required String id, required String urlSegment}) async {
    try {
      final response = await DioUtilNew.get("$urlSegment/confirmBuying/$id");
      print("response + " + response.data.toString());
      final data = CourseDetailsResponse.fromJson(response.data);
      return Right(data);
    } catch (error) {
      debugPrint(error.toString());
      return const Left("Something went wrong!");
    }
  }

  Future<Either<String, BookDetailsReponse>> getBookDetails({
    required String id,
  }) async {
    try {
      final response = await DioUtilNew.get("books/confirmBuying/$id");
      final data = BookDetailsReponse.fromJson(response.data);
      return Right(data);
    } catch (error) {
      debugPrint(error.toString());
      return const Left("Something went wrong!");
    }
  }

  Future<Either<String, ConfirmBuyingResponse>> confirmPayment(
      {required String id,
      required String type,
      required String method,
      required String coupon}) async {
    try {
      final response = await DioUtilNew.post('$type/confirmBuying/$id', data: {
        "coupon_code": coupon,
        "payment_method": method,
        "currency": "usd",
      });
      print("response + " + response.data.toString());
      final data = ConfirmBuyingResponse.fromJson(response.data);
      if (response.statusCode == 200) {
        return Right(data);
      } else {
        return Left(data.data?.message ?? "Something went wrong!");
      }
    } catch (error) {
      debugPrint(error.toString());
      return const Left("Something went wrong!");
    }
  }
}
