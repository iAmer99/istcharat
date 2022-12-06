import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:istchrat/main.dart';
import 'package:istchrat/screens/teacher/teacher_main/cubit/main_teacher_state.dart';
import 'package:istchrat/screens/teacher/teacher_main/domain/main_teacher_repo.dart';
import 'package:istchrat/screens/teacher/teacher_main/models/MainTeacherModel.dart';
import 'package:istchrat/shared_components/constants/constants.dart';
import 'package:istchrat/usecases/set_device_token.dart';

class MainTeacherCubit extends Cubit<MainTeacherState>{
  MainTeacherCubit() : super(MainTeacherInitial());
  static MainTeacherCubit get(context) => BlocProvider.of(context);
  static final repository = MainTeacherRepo();
  MainTeacherModel? teacher_model =  MainTeacherModel();
  bool isLoading = true;
  getTeacherMainList() async {
    //print("HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH");
    print(isLoading);
    try {
      isLoading = true;
      teacher_model = await repository.getTeacherMain();
      isLoading = false;
     /* print("eeeeeeeeeee" +
          teacher_model!.data!.length.toString()); */
      emit(MainTeacherSucess());
    } on DioError catch (e) {
      // print(e);
      isLoading = false;
      emit(MainTeacherFail(e.toString()));
    }
  }

  setDeviceToken() async{
    if(box.read(Constants.isLogged.toString())){
      await SetDeviceTokenUseCase.set();
    }
  }
}