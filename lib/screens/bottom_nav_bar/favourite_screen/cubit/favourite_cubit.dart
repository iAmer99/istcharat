import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:istchrat/screens/bottom_nav_bar/favourite_screen/cubit/favourite_states.dart';
import 'package:istchrat/screens/bottom_nav_bar/favourite_screen/repository/favourites_repo.dart';
import 'package:istchrat/screens/bottom_nav_bar/favourite_screen/repository/models/favourite_model.dart';
import 'package:istchrat/screens/login/login_screen.dart';
import 'package:istchrat/shared_components/constants/constants.dart';
import 'package:istchrat/usecases/removeFromFav.dart';

class FavouritesCubit extends Cubit<FavouritesStates> {
  FavouritesCubit() : super(FavouritesInitialState());

  static FavouritesCubit get(BuildContext context) =>
      BlocProvider.of<FavouritesCubit>(context);

  final FavouritesRepository _repository = FavouritesRepository();
  final box = GetStorage();
  FavouriteModel? favouriteBooks;
  FavouriteModel? favouriteOnlineCourses;
  FavouriteModel? favouriteRecordedCourses;

  Future getFavouriteBooks() async {
    emit(FavouriteBooksLoadingState());
    final response = await _repository.getFavouriteData(urlSegment: "books");
    response.fold((error) {
      emit(FavouriteBooksErrorState(error: error));
    }, (data) {
      favouriteBooks = data;
      emit(FavouriteBooksSuccessState());
    });
  }

  Future getFavouriteRecordedCourses(bool isLogged) async {
    if(isLogged){
      emit(FavouriteRecordedCoursesLoadingState());
      final response =
      await _repository.getFavouriteData(urlSegment: "offlineCourses");
      response.fold((error) {
        emit(FavouriteRecordedCoursesErrorState(error: error));
      }, (data) {
        favouriteRecordedCourses = data;
        emit(FavouriteRecordedCoursesSuccessState());
      });
    }
  }

  Future getFavouriteOnlineCourses() async {
    emit(FavouriteOnlineCoursesLoadingState());
    final response =
        await _repository.getFavouriteData(urlSegment: "onlineCourses");
    response.fold((error) {
      emit(FavouriteOnlineCoursesErrorState(error: error));
    }, (data) {
      favouriteOnlineCourses = data;
      emit(FavouriteOnlineCoursesSuccessState());
    });
  }

  Future removeBookToFav(String id) async {
    final response =
        await RemoveFromFavUseCase.removeFromToFav(id: id, urlSegment: "books");
    if (response) {
      favouriteBooks!.data!.rows!
          .removeWhere((element) => element.modelId == id);
      emit(RemovedFromFavSuccess());
    }
  }

  Future removeOnlineCourseToFav(String id) async {
    final response = await RemoveFromFavUseCase.removeFromToFav(
        id: id, urlSegment: "onlineCourses");
    if (response) {
      favouriteOnlineCourses!.data!.rows!
          .removeWhere((element) => element.modelId == id);
      emit(RemovedFromFavSuccess());
    }
  }

  Future removeRecordedCourseFromFav(String id) async {
    final response = await RemoveFromFavUseCase.removeFromToFav(
        id: id, urlSegment: "offlineCourses");
    if (response) {
      favouriteRecordedCourses!.data!.rows!
          .removeWhere((element) => element.modelId == id);
      emit(RemovedFromFavSuccess());
    }
  }
}
