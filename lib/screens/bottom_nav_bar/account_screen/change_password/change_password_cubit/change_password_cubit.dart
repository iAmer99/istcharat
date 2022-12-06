import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/change_password/change_password_cubit/change_password_states.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/change_password/repo/ChangePasswordModel.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/change_password/repo/change_password_repo.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordStates>{

  ChangePasswordCubit() : super(ChangePasswordInitialStates());

  static ChangePasswordCubit get(context)=> BlocProvider.of(context);

  ChangePasswordModel? changePasswordModel;
  ChangePasswordRepo changePasswordRepo = ChangePasswordRepo();

  changePassword(String oldPassword, String newPassword , String newPasswordConfirmation) async {
    try{
      print(">>>>>>>>>>>");
      emit(LoadingState());
      final response = await changePasswordRepo.changePassword(oldPassword, newPassword, newPasswordConfirmation);
      response.fold((error){
        emit(ChangePasswordFailed(error));
      }, (data){
        changePasswordModel= data;
        print("<<<<<<<<<<<");
        print(changePasswordModel!.data!.message);
        emit(ChangePasswordSuccess(changePasswordModel?.data?.message ?? "done".tr));
      });
    }
    catch(e){
      print(e);
      emit(ChangePasswordFailed("unknown_error".tr));
    }
  }
}