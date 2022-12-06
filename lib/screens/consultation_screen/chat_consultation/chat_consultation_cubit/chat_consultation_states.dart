import 'package:istchrat/screens/consultation_screen/chat_consultation/repo/ChatConsultationModel.dart';

abstract class ChatConsultationStates{}

class ChatConsultationInitialStates extends ChatConsultationStates{}

class GetConsultationDataSuccessfully extends ChatConsultationInitialStates{}

class ConsultationErrorState extends ChatConsultationInitialStates{}

class CheckDaySelectedIndex extends ChatConsultationInitialStates{}

class CheckTimeSelectedIndex extends ChatConsultationInitialStates{}

class CheckDurationSelectedIndex extends ChatConsultationInitialStates{}

class CheckSelectedMonth extends ChatConsultationInitialStates{
  Months months;
  CheckSelectedMonth(this.months);
}

class BookAppointmentSuccessfully extends ChatConsultationInitialStates{
  String bookID;
  BookAppointmentSuccessfully(this.bookID);
}

class BookAppointmentErrorState extends ChatConsultationInitialStates{}

class LoadingState extends ChatConsultationInitialStates{}

class BookAppointmentFailed extends ChatConsultationInitialStates{
  String message;
  BookAppointmentFailed(this.message);
}
class GetConsultationDataByMonth extends ChatConsultationInitialStates{
  Months month;
  GetConsultationDataByMonth(this.month);
}
class GetConsultationDataByPeriod extends ChatConsultationInitialStates{

}

class GetConsultationDataByDay extends ChatConsultationInitialStates{

}
