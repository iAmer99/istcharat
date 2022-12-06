abstract class ChatConfirmAppointmentStates{}

class ChatConfirmAppointmentInitialState extends ChatConfirmAppointmentStates{}

class GetChatConfirmAppointmentData extends ChatConfirmAppointmentInitialState{}

class ChatConfirmAppointmentError extends ChatConfirmAppointmentInitialState{}

class LoadingState extends ChatConfirmAppointmentInitialState{}
class ConfirmReservationSuccess extends ChatConfirmAppointmentInitialState{
  String message;
  String url;
  ConfirmReservationSuccess(this.message,this.url);
}
class WalletConfirmReservationSuccess extends ChatConfirmAppointmentInitialState{
  String message;
  WalletConfirmReservationSuccess(this.message,);
}
class ConfirmReservationFailed extends ChatConfirmAppointmentInitialState{
  String message;
  ConfirmReservationFailed(this.message);
}
class ConfirmReservationError extends ChatConfirmAppointmentInitialState{}

class CheckCouponSuccess extends ChatConfirmAppointmentInitialState{
  String message;
  CheckCouponSuccess(this.message);
}

class CheckCouponError extends ChatConfirmAppointmentStates{
  String message;
  CheckCouponError(this.message);
}

class BookedSuccessfully extends ChatConfirmAppointmentStates{
  final String message;

  BookedSuccessfully(this.message);
}