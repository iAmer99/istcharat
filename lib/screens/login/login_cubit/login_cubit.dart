import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:istchrat/screens/login/domain/login_repo.dart';
import 'package:istchrat/screens/login/login_cubit/login_states.dart';
import 'package:istchrat/shared_components/constants/constants.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';
import 'package:istchrat/usecases/change_language.dart';

import '../domain/login_model.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInitialStates());
  static LoginCubit get(context)=> BlocProvider.of(context);
  final LoginRepo _repo = LoginRepo();
  LoginModel? loginModel;
  final box = GetStorage();

  login(String email,String password) async {
      emit(LoadingState());
      final dio = DioUtilNew.dio!;
      final response = await _repo.login({
        "email": email,
        "password": password
      });
      response.fold((error){
        emit(WrongUserState(error));
      }, (data) async{
        loginModel = data;
        if(loginModel!.data!.email == null){
          emit(WrongUserState("unauthorized".tr));
        }else{
          saveUserData();
          await _repo.sendToken();
          DioUtilNew.setDioAgain();
          await ChangeLanguageUseCase.change(box.read(Constants.lang.toString()) ?? "en");
          emit(LoginSuccessState());
        }
      });
  }

 saveUserData(){
   box.write(Constants.userName.toString(),loginModel!.data!.username);
   box.write(Constants.email.toString(),loginModel!.data!.email);
   box.write(Constants.id.toString(),loginModel!.data!.id);
   box.write(Constants.accessToken.toString(),loginModel!.data!.accessToken);
   box.write(Constants.accessTokenType.toString(),loginModel!.data!.tokenType);
   box.write(Constants.avatar.toString(),loginModel!.data!.avatar);
   box.write(Constants.role.toString(),loginModel!.data!.role);
   box.write(Constants.isLogged.toString(), true);
 }

}