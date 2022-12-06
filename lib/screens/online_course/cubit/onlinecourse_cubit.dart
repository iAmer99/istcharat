import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:istchrat/screens/online_course/cubit/online_state.dart';
import 'package:istchrat/screens/online_course/domain/online_repo.dart';
import 'package:istchrat/screens/online_course/models/online_model.dart';
import 'package:istchrat/screens/recorded_course/cubit/recorded_state.dart';
import 'package:istchrat/screens/recorded_course/domain/recorded_repo.dart';
import 'package:istchrat/screens/recorded_course/models/recorded_course_model.dart';
import 'package:istchrat/usecases/addToFav.dart';
import 'package:istchrat/usecases/removeFromFav.dart';

class OnlineCourseCubit extends Cubit<OnlineState> {
  OnlineCourseCubit() : super(OnlineStateInitial());
  static OnlineCourseCubit get(context) => BlocProvider.of(context);
  static final repository = OnlineRepo();
  OnlineModel? online_model = new OnlineModel();
  bool isLoading = true;
  getOnlineList() async {
    print("HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH");
    print(isLoading);
    try {
      isLoading = true;
      online_model = await repository.getOnlineCourses();
      isLoading = false;
      print("eeeeeeeeeee" + online_model!.data!.onlineList!.length.toString());
      emit(OnlineStateSucess());
    } on DioError catch (e) {
      // print(e);
      isLoading = false;
      emit(OnlineStateError(e.toString()));
    }
  }
  getMyOnlineList(bool isLogged) async {
    if(isLogged){
      print("HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH");
      print(isLoading);
      try {
        isLoading = true;
        online_model = await repository.getMyOnlineCourses();
        isLoading = false;
        print("eeeeeeeeeee" + online_model!.data!.onlineList!.length.toString());
        emit(OnlineStateSucess());
      } on DioError catch (e) {
        // print(e);
        isLoading = false;
        emit(OnlineStateError(e.toString()));
      }
    }
  }
  Future addMyOnlineTofav(String id) async {
    final response =
        await AddToFavUseCase.addToFav(id: id, urlSegment: "onlineCourses");
    if (response) {
      online_model!.data!.onlineList!
          .firstWhere((element) => element.id.toString() == id)
          .is_favorite = true;
      emit(AddedMyOnlineToFavSuccess());
    }
  }

  Future removeMybooksFromFav(String id) async {
    final response = await RemoveFromFavUseCase.removeFromToFav(
        id: id, urlSegment: "onlineCourses");
    if (response) {
      online_model!.data!.onlineList!
          .firstWhere((element) => element.id.toString() == id)
          .is_favorite = false;
      emit(RemoveMyOnlineFav());
    }
  }
}
