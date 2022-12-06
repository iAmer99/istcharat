import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:istchrat/main.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/edit_account_information/edit_acc_info_cubit/edit_acc_info_states.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/edit_account_information/repo/AccountInfoModel.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/edit_account_information/repo/EditAccInfoModel.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/edit_account_information/repo/edit_acc_info_repo.dart';
import 'package:istchrat/shared_components/constants/constants.dart';

import '../../../../login/login_screen.dart';

class EditAccInfoCubit extends Cubit<EditAccInfoStates>{
  EditAccInfoCubit() : super(EditAccInfoInitialStates());

  static EditAccInfoCubit get(context)=> BlocProvider.of(context);

  AccountInfoModel? accInfoModel;
  EditAccInfoRepo accInfoRepo = EditAccInfoRepo();
  EditAccInfoModel? editAccInfoModel;
  bool isLoading = false;
  bool isError = false;

  getAccountInformation() async {
    try{
      isLoading = true;
      isError = false;
      accInfoModel = await accInfoRepo.getAccountInformation();
      print(accInfoModel!.row!.email);
      isLoading = false;
      emit(GetAccInfoSuccess(accInfoModel!));
    }
    catch(e){
      isLoading = false;
      isError = true;
      print(e);
      emit(GetAccInfoSuccessError());
    }
  }

  editAccountInformation(String name, String mobile , String imageBase64) async {
    try{
      emit(LoadingState());
      editAccInfoModel = await accInfoRepo.editAccountInformation(name, mobile, imageBase64);
      print(editAccInfoModel!.row!.email);
      final oldPic = box.read(Constants.avatar.toString());
      if(oldPic != editAccInfoModel?.row?.image){
        box.write(Constants.avatar.toString(), editAccInfoModel!.row!.image!);
      }
      emit(UpdateAccInfoSuccessfully());
    }
    catch(e){
      print(e);
    }
  }

  deleteAccount() async{
    emit(LoadingState());
    final response = await accInfoRepo.deleteAccount();
    response.fold((error){
      emit(DeleteAccountError(error));
    }, (res){
      box.remove(Constants.accessToken.toString());
      box.write(Constants.isLogged.toString(), false);
      box.remove(Constants.email.toString());
      box.remove(Constants.userName.toString());
      box.remove(Constants.avatar.toString());
      emit(DeleteAccountSuccess());
      Get.offAll(() => LoginScreen(comeFromHome: false));
    });
  }
}