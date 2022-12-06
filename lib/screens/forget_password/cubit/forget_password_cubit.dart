import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:istchrat/screens/forget_password/cubit/forget_password_states.dart';
import 'package:istchrat/screens/forget_password/repo/ForgetPasswordModel.dart';
import 'package:istchrat/screens/forget_password/repo/forget_password_repo.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitialStates());

  static ForgetPasswordCubit get(context) => BlocProvider.of(context);

  ForgetPasswordModel? forgetPasswordModel;
  ForgetPasswordRepo forgetPasswordRepo = ForgetPasswordRepo();

  forgetPassword(String email) async {
    try {
      emit(LoadingState());
      final response = await forgetPasswordRepo.forgetPassword(email);
      response.fold((error) {
        emit(ForgetPasswordFailed(error));
      }, (data) {
        forgetPasswordModel = data;
        print(forgetPasswordModel!.data!.message);
        emit(ForgetPasswordSuccess("done".tr));
      });
    } catch (e) {
      print(e);
      emit(ForgetPasswordFailed("unknown_error".tr));
    }
  }

  verify(String email, String code) async {
    try {
      emit(LoadingState());
      final response = await forgetPasswordRepo.verify(email, code);
      response.fold((error) {
        emit(ForgetPasswordFailed(error));
      }, (data) {
        forgetPasswordModel = data;
        print(forgetPasswordModel!.data!.message);
        emit(ForgetPasswordSuccess("done".tr));
      });
    } catch (e) {
      print(e);
      emit(ForgetPasswordFailed("unknown_error".tr));
    }
  }

  Future<void> resendCode(String email) async {
    emit(LoadingState());
    final response = await forgetPasswordRepo.forgetPassword(email);
    response.fold((error) {
      emit(ResentCodeError(error));
    }, (data) {
      emit(ResentCodeSuccessfully(data.data?.message ?? "code_resent".tr));
    });
  }

  resetNewPassword(String email, String code, String password) async {
    try {
      emit(LoadingState());
      final response =
          await forgetPasswordRepo.resetNewPassword(email, code, password);
      response.fold((error) {
        emit(ForgetPasswordFailed(error));
      }, (data) {
        forgetPasswordModel = data;
        print(forgetPasswordModel!.data!.message);
        emit(ForgetPasswordSuccess(forgetPasswordModel?.data?.message ?? "password_changed".tr));
      });
    } catch (e) {
      print(e);
      emit(ForgetPasswordFailed("unknown_error".tr));
    }
  }
}
