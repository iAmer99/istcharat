import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:istchrat/screens/main/domain/main_repository.dart';
import 'package:istchrat/screens/main/models/home_model.dart';
import 'package:istchrat/usecases/addToFav.dart';
import 'package:istchrat/usecases/removeFromFav.dart';

import '../../../main.dart';
import '../../../shared_components/constants/constants.dart';
import '../../../usecases/set_device_token.dart';
import 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  static MainCubit get(context) => BlocProvider.of(context);
  static final repository = MainRepository();
  HomeModel? homeData = new HomeModel();
  bool isLoading = true;

  getHomeData() async {
    print("HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH");
    print(isLoading);
    try {
      isLoading = true;
      homeData = await repository.getHomeData();
      isLoading = false;
      //print("eeeeeeeeeee" + homeData!.data!.sliders!.length.toString());
      emit(MainSuceess());
    } on DioError catch (e) {
      // print(e);
      isLoading = false;
      emit(MainError(e.toString()));
    }
  }

  setDeviceToken() async{
    if(box.read(Constants.isLogged.toString())){
      await SetDeviceTokenUseCase.set();
    }
  }

  Future addBookToFav(String id) async {
    final response = await AddToFavUseCase.addToFav(id: id, urlSegment: "books");
    if (response) {
      homeData!.data!.booksAuthors!
          .firstWhere((element) => element.id.toString() == id)
          .isFave = true;
      print("done");
      emit(AddedToFavSuccess());
    }
  }

  Future addOnlineCourseToFav(String id) async {
    final response = await AddToFavUseCase.addToFav(id: id, urlSegment: "onlineCourses");
    if (response) {
      homeData!.data!.onlineCourses!
          .firstWhere((element) => element.id.toString() == id)
          .isFave = true;
      emit(AddedToFavSuccess());
    }
  }

  Future addRecordedCourseToFav(String id) async {
    final response = await AddToFavUseCase.addToFav(id: id, urlSegment: "offlineCourses");
    if (response) {
      homeData!.data!.offlineCourses!
          .firstWhere((element) => element.id.toString() == id)
          .isFave = true;
      emit(AddedToFavSuccess());
    }
  }

  Future removeBookToFav(String id) async {
    final response = await RemoveFromFavUseCase.removeFromToFav(id: id, urlSegment: "books");
    if (response) {
      homeData!.data!.booksAuthors!
          .firstWhere((element) => element.id.toString() == id)
          .isFave = false;
      print("done");
      emit(RemovedFromFavSuccess());
    }
  }

  Future removeOnlineCourseToFav(String id) async {
    final response = await RemoveFromFavUseCase.removeFromToFav(id: id, urlSegment: "onlineCourses");
    if (response) {
      homeData!.data!.onlineCourses!
          .firstWhere((element) => element.id.toString() == id)
          .isFave = false;
      emit(RemovedFromFavSuccess());
    }
  }

  Future removeRecordedCourseFromFav(String id) async {
    final response = await RemoveFromFavUseCase.removeFromToFav(id: id, urlSegment: "offlineCourses");
    if (response) {
      homeData!.data!.offlineCourses!
          .firstWhere((element) => element.id.toString() == id)
          .isFave = false;
      emit(RemovedFromFavSuccess());
    }
  }
}
