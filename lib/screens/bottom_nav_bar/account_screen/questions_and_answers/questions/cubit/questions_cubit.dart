import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/questions_and_answers/questions/cubit/questions_states.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/questions_and_answers/questions/repo/QuestionsModel.dart';
import 'package:istchrat/screens/bottom_nav_bar/account_screen/questions_and_answers/questions/repo/questions_repo.dart';

class QuestionsCubit extends Cubit<QuestionsStates>{

  QuestionsCubit() : super(QuestionsInitialStates());

  static QuestionsCubit get(context)=> BlocProvider.of(context);

  QuestionsModel? questionsModel;
  QuestionsRepo repo = QuestionsRepo();
  bool isLoading = false;
  bool isError = false;

  getQuestions() async {
    try{
      isLoading = true;
      isError = false;
      questionsModel = await repo.getQuestions();
      print(questionsModel!.data!.rows![0].question);
      isLoading = false;
      emit(GetQuestionsSuccess());
    }
    catch(e){
      print(e);
      print(">>>>>>>>>>>>");
      isLoading = false;
      isError = true;
      emit(GetQuestionsError());
    }
  }

}