import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:istchrat/screens/book_details/cubit/books_details_state.dart';
import 'package:istchrat/screens/recorded_course/cubit/recorded_state.dart';
import 'package:istchrat/screens/recorded_course/domain/recorded_repo.dart';
import 'package:istchrat/screens/recorded_course/models/recorded_course_model.dart';
import 'package:istchrat/usecases/addToFav.dart';
import 'package:istchrat/usecases/removeFromFav.dart';

class RecordedCourseCubit extends Cubit<RecordedState> {
  RecordedCourseCubit() : super(RecordedStateInitial());
  static RecordedCourseCubit get(context) => BlocProvider.of(context);
  static final repository = RecordedRepo();
  Recorded_course_model? recorded_model = new Recorded_course_model();
  bool isLoading = true;
  getRecordedList() async {
    //print("HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH");
    print(isLoading);
    try {
      isLoading = true;
      recorded_model = await repository.getRecordedCourses();
      isLoading = false;
      print("eeeeeeeeeee" +
          recorded_model!.data!.recordedList!.length.toString());
      emit(RecordedStateSucess());
    } on DioError catch (e) {
      // print(e);
      isLoading = false;
      emit(RecordedStateError(e.toString()));
    }
  }
  getMyRecordedList(bool isLogged) async {
    //print("HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH");
   if(isLogged){
     print(isLoading);
     try {
       isLoading = true;
       recorded_model = await repository.getMyRecordedCourses();
       isLoading = false;
       print("eeeeeeeeeee" +
           recorded_model!.data!.recordedList!.length.toString());
       emit(RecordedStateSucess());
     } on DioError catch (e) {
       // print(e);
       isLoading = false;
       emit(RecordedStateError(e.toString()));
     }
   }
  }
  Future addMyRecordedTofav(String id) async {
    final response =
        await AddToFavUseCase.addToFav(id: id, urlSegment: "offlineCourses");
    if (response) {
      recorded_model!.data!.recordedList!
          .firstWhere((element) => element.id.toString() == id)
          .is_favorite = true;
      emit(AddRecordedToFavSuccess());
    }
  }

  Future removeMyRecordedFromFav(String id) async {
    final response = await RemoveFromFavUseCase.removeFromToFav(
        id: id, urlSegment: "offlineCourses");
    if (response) {
      recorded_model!.data!.recordedList!
          .firstWhere((element) => element.id.toString() == id)
          .is_favorite = false;
      emit(RemovedRecordedFromFavSuccess());
    }
  }
}
