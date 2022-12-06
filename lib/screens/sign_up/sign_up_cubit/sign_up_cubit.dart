import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:istchrat/screens/sign_up/domain/sign_up_model1.dart';
import 'package:istchrat/screens/sign_up/domain/sign_up_repo.dart';
import 'package:istchrat/screens/sign_up/sign_up_cubit/sign_up_states.dart';
import 'package:istchrat/shared_components/dio_helper/dio_util_new.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpInitialState());

  static SignUpCubit get(context) => BlocProvider.of(context);

  SignUpModel1? signUpModel;
  SignUpRepo signUpRepo = SignUpRepo();
  String countryCode = "+965";

  signUp(String name, String email, String password, String phoneNumber) async {
    try {
      final dio = DioUtilNew.dio;
      emit(LoadingState());
      print("bbbbbbb");
      final response =  await signUpRepo.signUp(name, email, password, phoneNumber, countryCode);
      signUpModel = SignUpModel1.fromJson(response.data);
      print(signUpModel!.data!.message);
      print(">>>>>>>>>>>>>>");
      if(response.statusCode == 200){
        DioUtilNew.setDioAgain();
        emit(SignUpSuccessState(signUpModel?.data?.message ?? ""));
      }else{
        emit(SignUpErrorState(signUpModel?.data?.message ?? ""));
      }
    } catch (e) {
      print("zzzzzzzzzzz");
      print(e.toString());
      emit(SignUpErrorState("unknown_error".tr));
    }
  }
}
