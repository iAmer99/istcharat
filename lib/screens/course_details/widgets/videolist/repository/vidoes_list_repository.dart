

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:istchrat/screens/course_details/widgets/videolist/repository/model/video_list_model.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';

class VideosListRepository {
  final Dio _dio = DioUtilNew.dio!;
  
  Future<Either<String, List<VideosList>>> getVideosList({required String segment, required String id}) async{
    try{
      final response = await DioUtilNew.get("/$segment/mylibrary/$id/videos");
      print(response.data.toString());
      final data = VideoListModel.fromJson(response.data);
      return Right(data.row!.videosList ?? []);
    }catch(error){
      print(error.toString());
      return const Left("Something went wrong!");
    }
  }
}