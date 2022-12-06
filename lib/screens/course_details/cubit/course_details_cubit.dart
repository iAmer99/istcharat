import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:istchrat/screens/course_details/cubit/course_details_state.dart';
import 'package:istchrat/screens/course_details/domain/repo_details.dart';
import 'package:istchrat/screens/course_details/models/course_details_model.dart';
import 'package:istchrat/usecases/addToFav.dart';
import 'package:istchrat/usecases/removeFromFav.dart';

import '../../../usecases/buy/buy_usecase.dart';
import '../../in_app_purchase_screen/repository/iap_repository.dart';

class CourseDetailsCubit extends Cubit<CourseDetailsState> {
  CourseDetailsCubit() : super(CourseDetailsInitial());
  static CourseDetailsCubit get(context) => BlocProvider.of(context);
  static final repository = RepoDetails();
  CourseDetailsModel? offlineDetailsList = new CourseDetailsModel();
  bool isLoading = true;
  getOfflineCourseDetails(int id) async {
    print(isLoading);
    try {
      isLoading = true;
      offlineDetailsList = await repository.getRepoDetails(id);
      isLoading = false;
      //print("eeeeeeeeeee" + offlineDetailsList!.row!.title.toString());
      emit(CourseDetailsSuccess());
    } on DioError catch (e) {
      // print(e);
      isLoading = false;
      emit(CourseDetailsError(e.toString()));
    }
  }

  Future removeRecordedCourseFromFav(String id) async {
   if(!isLoading){
     final response = await RemoveFromFavUseCase.removeFromToFav(id: id, urlSegment: "offlineCourses");
     if (response) {
       offlineDetailsList!.row!.isFav = false;
       emit(RemovedFromFavSuccess());
     }
   }
  }

  Future addRecordedCourseToFav(String id) async {
    if(!isLoading){
      final response = await AddToFavUseCase.addToFav(id: id, urlSegment: "offlineCourses");
      if (response) {
        offlineDetailsList!.row!.isFav = true;
        emit(AddedToFavSuccess());
      }
    }
  }

  Future buyCourse(String id) async {
    emit(BuyLoadingState());
    final response = await BuyUseCase.buy(
        type: "offlineCourses", service: "buyCourse", map: {"course_id": id});

    response.fold((error){
      emit(BuyErrorState(error));
    }, (data){
      emit(BuySuccessState(message: data.data?.message ?? "", id: data.data?.orderId?.toString() ?? ""));
    });
  }

  Future<void> addCourseToLibrary(String id) async{
    emit(BuyLoadingState());
    final IAPRepository iapRepository = IAPRepository();
    final response = await iapRepository.buyItem(id: id, type: "offline_course_attendances");
    response.fold((error){
      emit(BuyErrorState(error));
    }, (data){
      emit(FreeBuySuccessState(message: "added_to_library".trParams({
        "product" : "Course".tr
      })));
    });
  }

  /* getOnlineCourseDetails(int id) async {
    print(isLoading);
    try {
      isLoading = true;
      offlineDetailsList = await repository.getRepoDetails(id);
      isLoading = false;
      print("eeeeeeeeeee" + offlineDetailsList!.row!.title.toString());
      emit(CourseDetailsSuccess());
    } on DioError catch (e) {
      // print(e);
      isLoading = false;
      emit(CourseDetailsError(e.toString()));
    }
  }*/
}
