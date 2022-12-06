abstract class AudioConfirmAppointmentStates{}

class AudioConfirmAppointmentInitialState extends AudioConfirmAppointmentStates{}

class GetAudioConfirmAppointmentData extends AudioConfirmAppointmentInitialState{}

class AudioConfirmAppointmentError extends AudioConfirmAppointmentInitialState{}

class LoadingState extends AudioConfirmAppointmentInitialState{}
class ConfirmReservationSuccess extends AudioConfirmAppointmentInitialState{
  String message;
  String url;
  ConfirmReservationSuccess(this.message,this.url);
}
class WalletConfirmReservationSuccess extends AudioConfirmAppointmentInitialState{
  String message;
  WalletConfirmReservationSuccess(this.message,);
}
class ConfirmReservationFailed extends AudioConfirmAppointmentInitialState{
  String message;
  ConfirmReservationFailed(this.message);
}
class ConfirmReservationError extends AudioConfirmAppointmentInitialState{}
class CheckCouponSuccess extends AudioConfirmAppointmentInitialState{
  String message;
  CheckCouponSuccess(this.message);
}

class CheckCouponError extends AudioConfirmAppointmentStates{
  String message;
  CheckCouponError(this.message);
}

class BookedSuccessfully extends AudioConfirmAppointmentStates{
  final String message;

  BookedSuccessfully(this.message);
}