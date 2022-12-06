import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:istchrat/screens/course_details/models/course_details_model.dart';
import 'package:istchrat/screens/course_details/online_details/cubit/online_course_details_state.dart';
import 'package:istchrat/screens/course_details/online_details/domain/online_repo_details.dart';
import 'package:istchrat/screens/course_details/online_details/models/online_details_model.dart';
import 'package:istchrat/usecases/addToFav.dart';
import 'package:istchrat/usecases/buy/buy_usecase.dart';
import 'package:istchrat/usecases/removeFromFav.dart';

import '../../../in_app_purchase_screen/repository/iap_repository.dart';

class OnlineCourseDetailsCubit extends Cubit<OnlineCourseDetailsState> {
  OnlineCourseDetailsCubit() : super(OnlineCourseDetailsInitial());

  static OnlineCourseDetailsCubit get(context) =>
      BlocProvider.of<OnlineCourseDetailsCubit>(context);
  static final repository = OnlineRepoDetails();
  Online_details_model? onlineeDetailsList = new Online_details_model();
  bool isLoading = true;

  getOnlineCourseDetails(int id) async {
    print(isLoading);
    try {
      isLoading = true;
      onlineeDetailsList = await repository.getOnlineDetails(id);

      //print("eeeeeeeeeee" + onlineeDetailsList!.row!.title.toString());
      emit(OnlineCourseDetailsSuccess());
      isLoading = false;
    } on DioError catch (e) {
      // print(e);
      isLoading = false;
      emit(OnlineCourseDetailsError(e.toString()));
    }
  }

  Future addOnlineCourseToFav(String id) async {
    if (!isLoading) {
      final response =
          await AddToFavUseCase.addToFav(id: id, urlSegment: "onlineCourses");
      if (response) {
        onlineeDetailsList!.row!.isFav = true;
        emit(AddedToFavSuccess());
      }
    }
  }

  Future removeOnlineCourseToFav(String id) async {
    if (!isLoading) {
      final response = await RemoveFromFavUseCase.removeFromToFav(
          id: id, urlSegment: "onlineCourses");
      if (response) {
        onlineeDetailsList!.row!.isFav = false;
        emit(RemovedFromFavSuccess());
      }
    }
  }

  Future buyCourse(String id) async {
    emit(OnlineCourseBuyLoadingState());
    final response = await BuyUseCase.buy(
        type: "onlineCourses", service: "buyCourse", map: {"course_id": id});

    response.fold((error){
      emit(OnlineCourseBuyErrorState(error));
    }, (data){
      emit(OnlineCourseBuySuccessState(message:data.data?.message ?? "", id: data.data?.orderId?.toString() ?? ""));
    });
  }

  Future<void> addCourseToLibrary(String id) async{
    emit(OnlineCourseBuyLoadingState());
    final IAPRepository iapRepository = IAPRepository();
    final response = await iapRepository.buyItem(id: id, type: "online_course_attendances");
    response.fold((error){
      emit(OnlineCourseBuyErrorState(error));
    }, (data){
      emit(OnlineCourseFreeBuySuccessState(message: "added_to_library".trParams({
        "product" : "Course".tr
      })));
    });
  }
}
