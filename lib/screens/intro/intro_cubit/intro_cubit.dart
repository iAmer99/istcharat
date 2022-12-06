
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:istchrat/screens/intro/domain/IntroModel.dart';
import 'package:istchrat/screens/intro/domain/intro_repo.dart';
import 'package:istchrat/screens/intro/intro_cubit/intro_states.dart';

class IntroCubit extends Cubit<IntroStates>{

  IntroCubit() : super(IntroInitialStates());

  static IntroCubit get(context) => BlocProvider.of(context);
  
  IntroRepo introRepo = IntroRepo();
  IntroModel? introModel;
  List<Rows>? introList = [];
  bool isLoading = false;


  getIntroData() async {
    try{
      isLoading = true;
      introModel = await introRepo.getIntroData();
      introList = introModel!.data!.rows!;
      print(introList![0].youtubeLink);
      print(introList![1].image);
      print(introList![2].image);
      print(introList![0].id);
      isLoading = false;
      emit(GetIntroDataSuccessfully());
    }
    catch(e){
      print(e.toString());
      isLoading = false;
      emit(IntroErrorState());

    }
  }
}