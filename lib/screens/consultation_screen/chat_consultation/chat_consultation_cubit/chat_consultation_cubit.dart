import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:istchrat/screens/consultation_screen/chat_consultation/chat_consultation_cubit/chat_consultation_states.dart';
import 'package:istchrat/screens/consultation_screen/chat_consultation/repo/ChatBookAppointmentModel.dart';
import 'package:istchrat/screens/consultation_screen/chat_consultation/repo/ChatConsultationModel.dart';
import 'package:istchrat/screens/consultation_screen/chat_consultation/repo/chat_consultation_repo.dart';


class ChatConsultationCubit extends Cubit<ChatConsultationStates>{

  ChatConsultationCubit() : super(ChatConsultationInitialStates());

  static ChatConsultationCubit get(context)=> BlocProvider.of(context);

  ChatConsultationRepo chatConsultationRepo = ChatConsultationRepo();
  ChatConsultationModel? chatConsultationModel;
  ChatBookAppointmentModel? chatBookAppointmentModel;
  bool isLoading = false;
  int selectedIndex = 0;
  int timeSelectedIndex = 0;
  int durationSelectedIndex = 0;
  Months? selectedMonth;
  bool isError = false;

  getChatConsultationData(String month,String period,String consultationType) async {
    try{
      isLoading = true;
      isError = false;
      chatConsultationModel = await chatConsultationRepo.getChatConsultationData(month: month, period: period, consultationType: consultationType);
      selectedMonth = chatConsultationModel!.data!.months![0];
      isLoading = false;
      emit(GetConsultationDataSuccessfully());
    }
    catch(e){
      print(e);
      isLoading = false;
      isError = true;
      emit(ConsultationErrorState());

    }

  }
  getVideoConsultationByMonth(String month,String period,Months monthValue,String consultationType) async {
    try{
      // isLoading = true;
      chatConsultationModel = await chatConsultationRepo.getChatConsultationData(month: month, period: period, consultationType: consultationType);
      // selectedMonth = videoConsultationModel!.data!.months![0];
      for(int x =0; x< chatConsultationModel!.data!.months!.length ; x++){
        if(monthValue.key.toString() == chatConsultationModel!.data!.months![x].key.toString()){
          selectedMonth = chatConsultationModel!.data!.months![x];
        }
      }
      // checkSelectedMonth(monthValue);
      print(selectedMonth!.value);
      print(monthValue.value);
      print(">>>>>>>>>>");
      isLoading = false;
      emit(GetConsultationDataByMonth(monthValue));
    }
    catch(e){
      print(e);
      isLoading = false;
      emit(ConsultationErrorState());

    }
  }
  getVideoConsultationByPeriod(String month,String period,Months monthValue,String consultationType, String day) async {
    try{
      chatConsultationModel = await chatConsultationRepo.getChatConsultationData(month: month, period: period, consultationType: consultationType, day: day);
      for(int x =0; x< chatConsultationModel!.data!.months!.length ; x++){
        if(monthValue.key.toString() == chatConsultationModel!.data!.months![x].key.toString()){
          selectedMonth = chatConsultationModel!.data!.months![x];
        }
      }
      isLoading = false;
      emit(GetConsultationDataByPeriod());
    }
    catch(e){
      print(e);
      isLoading = false;
      emit(ConsultationErrorState());

    }
  }

  getDataByDay(String month,String period,Months monthValue,String consultationType, String day) async{
    try{
      chatConsultationModel = await chatConsultationRepo.getChatConsultationData(month: month, period: period, consultationType: consultationType, day: day);
      for(int x =0; x< chatConsultationModel!.data!.months!.length ; x++){
        if(monthValue.key.toString() == chatConsultationModel!.data!.months![x].key.toString()){
          selectedMonth = chatConsultationModel!.data!.months![x];
        }
      }
      isLoading = false;
      emit(GetConsultationDataByDay());
    }
    catch(e){
      print(e);
      isLoading = false;
      emit(ConsultationErrorState());

    }
  }

  getChatBookAppointmentData(String monthKey,String dayKey,String timeKey,String periodKey,String coupon,String consultationType) async {
    try{
      emit(LoadingState());
      chatBookAppointmentModel = await chatConsultationRepo.getChatBookAppointmentData(
          monthKey,dayKey,timeKey,periodKey,coupon,consultationType);
      print(chatBookAppointmentModel!.data!.message);
      if(chatBookAppointmentModel!.data!.bookId == null){
        emit(BookAppointmentFailed(chatBookAppointmentModel!.data!.message!));
      }else{
        print(chatBookAppointmentModel!.data!.bookId);
        emit(BookAppointmentSuccessfully(chatBookAppointmentModel!.data!.bookId.toString()));
      }
    }
    catch(e){
      print(e);
      emit(BookAppointmentErrorState());

    }

  }


  checkDaySelectedIndex(int index,) {
    selectedIndex = index;
    emit(CheckDaySelectedIndex());
  }

  checkTimeSelectedIndex(int index,) {
    timeSelectedIndex = index;
    emit(CheckTimeSelectedIndex());
  }

  checkDurationSelectedIndex(int index,) {
    durationSelectedIndex = index;
    emit(CheckDurationSelectedIndex());
  }
  checkSelectedMonth(Months month) {
    selectedMonth = month;
    emit(CheckSelectedMonth(selectedMonth!));
  }

}