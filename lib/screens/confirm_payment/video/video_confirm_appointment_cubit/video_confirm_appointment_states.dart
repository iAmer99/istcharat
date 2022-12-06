abstract class VideoConfirmAppointmentStates{}

class VideoConfirmAppointmentInitialState extends VideoConfirmAppointmentStates{}

class GetVideoConfirmAppointmentData extends VideoConfirmAppointmentInitialState{}

class VideoConfirmAppointmentError extends VideoConfirmAppointmentInitialState{}

class LoadingState extends VideoConfirmAppointmentInitialState{}
class ConfirmReservationSuccess extends VideoConfirmAppointmentInitialState{
  String message;
  String url;
  ConfirmReservationSuccess(this.message,this.url);
}
class WalletConfirmReservationSuccess extends VideoConfirmAppointmentInitialState{
  String message;
  WalletConfirmReservationSuccess(this.message,);
}
class ConfirmReservationFailed extends VideoConfirmAppointmentInitialState{
  String message;
  ConfirmReservationFailed(this.message);
}
class ConfirmReservationError extends VideoConfirmAppointmentInitialState{}

class CheckCouponSuccess extends VideoConfirmAppointmentInitialState{
  String message;
  CheckCouponSuccess(this.message);
}

class CheckCouponError extends VideoConfirmAppointmentStates{
  String message;
  CheckCouponError(this.message);
}

class BookedSuccessfully extends VideoConfirmAppointmentStates{
  final String message;

  BookedSuccessfully(this.message);
}