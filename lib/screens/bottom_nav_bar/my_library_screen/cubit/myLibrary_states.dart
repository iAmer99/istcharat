import 'package:istchrat/screens/bottom_nav_bar/my_library_screen/repository/model/OldConsultationDataModel.dart';

abstract class MyLibraryStates {}

class MyLibraryInitialState extends MyLibraryStates {}

// Video Consultations
abstract class MyLibraryVideoStates extends MyLibraryStates {}
class MyLibraryVideoLoadingState extends MyLibraryVideoStates {}
class MyLibraryVideoSuccessState extends MyLibraryVideoStates {
  final OldConsultationDataModel data;

  MyLibraryVideoSuccessState(this.data);

}
class MyLibraryVideoErrorState extends MyLibraryVideoStates {
  final String errorMsg;

  MyLibraryVideoErrorState(this.errorMsg);

}

// Audio Consultations
abstract class MyLibraryAudioStates extends MyLibraryStates {}
class MyLibraryAudioLoadingState extends MyLibraryAudioStates {}
class MyLibraryAudioSuccessState extends MyLibraryAudioStates {
  final OldConsultationDataModel data;

  MyLibraryAudioSuccessState(this.data);

}
class MyLibraryAudioErrorState extends MyLibraryAudioStates {
  final String errorMsg;

  MyLibraryAudioErrorState(this.errorMsg);
}

// Chat Consultations
abstract class MyLibraryChatStates extends MyLibraryStates {}
class MyLibraryChatLoadingState extends MyLibraryChatStates {}
class MyLibraryChatSuccessState extends MyLibraryChatStates {
  final OldConsultationDataModel data;

  MyLibraryChatSuccessState(this.data);
}
class MyLibraryChatErrorState extends MyLibraryChatStates {
  final String errorMsg;

  MyLibraryChatErrorState(this.errorMsg);
}

// Faqs Consultations
abstract class MyLibraryFaqsStates extends MyLibraryStates {}
class MyLibraryFaqsLoadingState extends MyLibraryFaqsStates {}
class MyLibraryFaqsSuccessState extends MyLibraryFaqsStates {
  final OldConsultationDataModel data;

  MyLibraryFaqsSuccessState(this.data);
}
class MyLibraryFaqsErrorState extends MyLibraryFaqsStates {
  final String errorMsg;

  MyLibraryFaqsErrorState(this.errorMsg);
}

// Appointment Consultations
abstract class MyLibraryAppointmentStates extends MyLibraryStates {}
class MyLibraryAppointmentLoadingState extends MyLibraryAppointmentStates {}
class MyLibraryAppointmentSuccessState extends MyLibraryAppointmentStates {
  final OldConsultationDataModel data;

  MyLibraryAppointmentSuccessState(this.data);
}
class MyLibraryAppointmentErrorState extends MyLibraryAppointmentStates {
  final String errorMsg;

  MyLibraryAppointmentErrorState(this.errorMsg);
}

// Emergency Consultations
abstract class MyLibraryEmergencyStates extends MyLibraryStates {}
class MyLibraryEmergencyLoadingState extends MyLibraryEmergencyStates {}
class MyLibraryEmergencySuccessState extends MyLibraryEmergencyStates {
  final OldConsultationDataModel data;

  MyLibraryEmergencySuccessState(this.data);
}
class MyLibraryEmergencyErrorState extends MyLibraryEmergencyStates {
  final String errorMsg;

  MyLibraryEmergencyErrorState(this.errorMsg);
}