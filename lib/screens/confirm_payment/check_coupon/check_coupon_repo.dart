import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:istchrat/screens/confirm_payment/check_coupon/CheckCouponModel.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';

class CheckCouponRepo{

  final dio = DioUtilNew.dio;

  Future<Either<CheckCouponModel, CheckCouponModel>> checkCoupon(String consultationType,String coupon, String id) async {
    try{
      final result = await DioUtilNew.post("$consultationType/checkCoupon",
        data: {
          "coupon": coupon,
          "item_id" : id,
        },
      );
      print("response : ${result.data}");
      if(result.statusCode == 500){
        return Left( CheckCouponModel.fromJson(result.data));
      }else{
        return Right(CheckCouponModel.fromJson(result.data));
      }
    }
    catch(e){
      print(e);
      return Left(CheckCouponModel(data: Data(message: "unknown_error".tr)));
    }
  }
}