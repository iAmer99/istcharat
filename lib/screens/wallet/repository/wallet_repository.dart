import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:istchrat/screens/wallet/repository/model/WalletResponse.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';


class WalletRepository {
  final Dio _dio = DioUtilNew.dio!;

  Future<Either<String, WalletResponse>> getWalletData() async{
    try{
      final response = await DioUtilNew.post("auth/wallet");
      final data = WalletResponse.fromJson(response.data);
      return Right(data);
    }catch(error){
      debugPrint(error.toString());
      return const Left("Something went wrong!");
    }
  }
}