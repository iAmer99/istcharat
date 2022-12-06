import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    BaseOptions options = new BaseOptions(
      baseUrl: 'https://api-istchrat.mazadak.net/api/v1',
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
    options.connectTimeout = 10 * 1000; //10 sec
    options.receiveTimeout = 20 * 1000; //20 sec
  }

  static Future<Response> getData({
    @required String? url,
    @required Map<String, dynamic>? query,
  }) async {
    return await dio!.get(
      url!,
      queryParameters: query,
    );
  }

  void getName() async {}

  static Future<Response> getPostData({
    @required String? url,
    @required dynamic data,
    Map<String, dynamic>? query,
  }) async {
    return await dio!.post(
      url!,
      queryParameters: query,
      data: data,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      }),
    );
  }

  // delete
  static Future<Response> deleteData({
    @required String? url,
    Map<String, dynamic>? query,
  }) async {
    return await dio!.delete(
      url!,
      queryParameters: query,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      }),
    );
  }
}
