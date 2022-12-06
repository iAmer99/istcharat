abstract class ConfirmQuestionAnswerStates{}

class ConfirmQuestionAnswerInitialState extends ConfirmQuestionAnswerStates{}

class GetQuestionConfirmAppointmentData extends ConfirmQuestionAnswerInitialState{}

class QuestionConfirmAppointmentError extends ConfirmQuestionAnswerInitialState{}

class LoadingState extends ConfirmQuestionAnswerInitialState{}
class ConfirmReservationSuccess extends ConfirmQuestionAnswerInitialState{
  String message;
  String url;
  ConfirmReservationSuccess(this.message,this.url);
}

class WalletConfirmReservationSuccess extends ConfirmQuestionAnswerInitialState{
  String message;
  WalletConfirmReservationSuccess(this.message,);
}
class ConfirmReservationFailed extends ConfirmQuestionAnswerInitialState{
  String message;
  ConfirmReservationFailed(this.message);
}
class ConfirmReservationError extends ConfirmQuestionAnswerInitialState{}

class CheckCouponSuccess extends ConfirmQuestionAnswerInitialState{
  String message;
  CheckCouponSuccess(this.message);
}

class CheckCouponError extends ConfirmQuestionAnswerStates{
  String message;
  CheckCouponError(this.message);
}

class BookedSuccessfully extends ConfirmQuestionAnswerStates{
  final String message;

  BookedSuccessfully(this.message);
}