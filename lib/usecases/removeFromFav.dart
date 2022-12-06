

import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';

class RemoveFromFavUseCase {
  static  Future<bool> removeFromToFav({required String id, required String urlSegment}) async{
    try {
      final dio = DioUtilNew.dio;
      final result = await dio!.delete("favorites/$urlSegment/$id");
      if(result.statusCode == 200){
        return true;
      }else{
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}