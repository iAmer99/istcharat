
import '../consultation_model/VideoConsultationModel.dart';

abstract class VideoConsultationStates{}

class VideoConsultationInitialStates extends VideoConsultationStates{}

class GetConsultationDataSuccessfully extends VideoConsultationInitialStates{}

class GetConsultationDataByMonth extends VideoConsultationInitialStates{
  Months month;
  GetConsultationDataByMonth(this.month);
}
class GetConsultationDataByPeriod extends VideoConsultationInitialStates{

}

class GetConsultationDataByDay extends VideoConsultationInitialStates{

}

class ConsultationErrorState extends VideoConsultationInitialStates{}

class CheckDaySelectedIndex extends VideoConsultationStates{}

class CheckTimeSelectedIndex extends VideoConsultationStates{}

class CheckDurationSelectedIndex extends VideoConsultationStates{}

class CheckSelectedMonth extends VideoConsultationStates{
  Months month;
  CheckSelectedMonth(this.month);
}

class BookAppointmentSuccessfully extends VideoConsultationInitialStates{
  String bookID;
  BookAppointmentSuccessfully(this.bookID);
}

class BookAppointmentFailed extends VideoConsultationInitialStates{
  String message;
  BookAppointmentFailed(this.message);
}

class BookAppointmentErrorState extends VideoConsultationInitialStates{}

class LoadingState extends VideoConsultationInitialStates{}