import 'package:istchrat/screens/consultation_screen/audio_consultation/repo/AudioConsultationModel.dart';

abstract class AudioConsultationStates{}

class AudioConsultationInitialStates extends AudioConsultationStates{}

class GetConsultationDataSuccessfully extends AudioConsultationInitialStates{}

class ConsultationErrorState extends AudioConsultationInitialStates{}

class CheckDaySelectedIndex extends AudioConsultationInitialStates{}

class CheckTimeSelectedIndex extends AudioConsultationInitialStates{}

class CheckDurationSelectedIndex extends AudioConsultationInitialStates{}

class CheckSelectedMonth extends AudioConsultationInitialStates{
  Months months;
  CheckSelectedMonth(this.months);
}

class BookAppointmentSuccessfully extends AudioConsultationInitialStates{
  String bookID;
  BookAppointmentSuccessfully(this.bookID);
}

class BookAppointmentErrorState extends AudioConsultationInitialStates{}

class LoadingState extends AudioConsultationInitialStates{}

class BookAppointmentFailed extends AudioConsultationInitialStates{
  String message;
  BookAppointmentFailed(this.message);
}
class GetConsultationDataByMonth extends AudioConsultationInitialStates{
  Months month;
  GetConsultationDataByMonth(this.month);
}
class GetConsultationDataByPeriod extends AudioConsultationInitialStates{

}
class GetConsultationDataByDay extends AudioConsultationInitialStates{

}
