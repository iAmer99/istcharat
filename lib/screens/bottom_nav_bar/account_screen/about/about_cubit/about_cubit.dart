import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/about/about_cubit/about_states.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/about/repo/AboutModel.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/about/repo/about_repo.dart';

class AboutCubit extends Cubit<AboutStates>{

  AboutCubit() : super(AboutInitialStates());

  static AboutCubit get(context)=> BlocProvider.of(context);

  bool isLoading = true;
  bool isError = false;
  AboutModel? aboutModel;
  AboutRepo aboutRepo = AboutRepo();

  getAboutData(String type) async {
    try{
      isLoading = true;
      isError = false;
      aboutModel = await aboutRepo.getAboutData(type);
      print(aboutModel!.data!.body);
      isLoading = false;
      emit(GetAboutDataSuccess());
    }
    catch(e){
      print(e);
      print(">>>>>>>>>>>>");
      isLoading = false;
      isError = true;
      emit(GetAboutDataFailed());
    }
  }
}