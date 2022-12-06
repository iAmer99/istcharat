abstract class QuestionAnswerStates{}

class QuestionAnswerInitialStates extends QuestionAnswerStates{}

class GetQuestionAnswerDataSuccessfully extends QuestionAnswerInitialStates{}

class QuestionAnswerErrorState extends QuestionAnswerInitialStates{}

class BookAppointmentSuccessfully extends QuestionAnswerInitialStates{
  String bookID;
  BookAppointmentSuccessfully(this.bookID);
}

class BookAppointmentErrorState extends QuestionAnswerInitialStates{}

class LoadingState extends QuestionAnswerInitialStates{}

class BookAppointmentFailed extends QuestionAnswerInitialStates{
  String message;
  BookAppointmentFailed(this.message);
}