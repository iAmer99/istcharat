import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:istchrat/screens/question_and_answer/cubit/question_answer_states.dart';
import 'package:istchrat/screens/question_and_answer/repo/QuestionAnswerModel1.dart';
import 'package:istchrat/screens/question_and_answer/repo/QuestionBookModel.dart';
import 'package:istchrat/screens/question_and_answer/repo/question_answer_repo.dart';

class QuestionAnswerCubit extends Cubit<QuestionAnswerStates> {

  QuestionAnswerCubit() : super(QuestionAnswerInitialStates());

  static QuestionAnswerCubit get(context) => BlocProvider.of(context);

  QuestionAnswerModel1? questionAnswerModel;
  QuestionAnswerRepo questionAnswerRepo = QuestionAnswerRepo();
  QuestionBookModel? bookModel;
  bool isLoading = true;
  bool isError = false;

  getQuestionAnswerData(String consultationType) async {
    try {
      isLoading = true;
      isError = false;
      questionAnswerModel = await questionAnswerRepo.getQuestionAnswerData(consultationType);
      print(">>>>>>>>>>");
      /*print(questionAnswerModel!.data!.lecturer!.image);
      print(questionAnswerModel!.data!.lecturer!.university); */
      isLoading = false;
      emit(GetQuestionAnswerDataSuccessfully());
    }
    catch (e) {
      print(e);
      isLoading = false;
      isError = true;
      emit(QuestionAnswerErrorState());
    }
  }

  getBookQuestionData(String question,String consultationType) async {
    try{
      emit(LoadingState());
      bookModel = await questionAnswerRepo.getBookQuestionData(question,consultationType);
      print(bookModel!.data!.message);
      if(bookModel!.data!.bookId == null){
        emit(BookAppointmentFailed(bookModel!.data!.message!));
      }else{
        print(bookModel!.data!.bookId);
        emit(BookAppointmentSuccessfully(bookModel!.data!.bookId.toString()));
      }
    }
    catch(e){
      print(e);
      emit(BookAppointmentErrorState());

    }
  }

}