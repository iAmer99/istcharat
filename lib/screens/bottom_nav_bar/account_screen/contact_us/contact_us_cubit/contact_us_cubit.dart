import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/contact_us/contact_us_cubit/contact_us_states.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/contact_us/repo/ContactUsModel.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/contact_us/repo/contact_us_repo.dart';

class ContactUsCubit extends Cubit<ContactUsStates>{

  ContactUsCubit() : super(ContactUsInitialStates());

  static ContactUsCubit get(context)=> BlocProvider.of(context);

  ContactUsModel? contactUsModel;
  ContactUsRepo contactUsRepo = ContactUsRepo();

  contactUs(String name, String email , String question) async {
    try{
      emit(LoadingState());
      contactUsModel = await contactUsRepo.contactUs(name, email, question);
      print(contactUsModel!.data!.message);
      emit(ContactUsSuccess(contactUsModel!.data!.message.toString()));
    }
    catch(e){
      print(e);
      if(e is DioError){
        print(e.response?.data.toString());
        emit(ContactUsError(e.response?.data['message'] ?? "unknown_error".tr));
      }
      emit(ContactUsError("unknown_error".tr));
    }
  }

}