import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:istchrat/screens/consultation_screen/audio_consultation/audio_consultation_cubit/audio_consultation_states.dart';
import 'package:istchrat/screens/consultation_screen/audio_consultation/repo/AudioBookAppointmentModel.dart';
import 'package:istchrat/screens/consultation_screen/audio_consultation/repo/AudioConsultationModel.dart';
import 'package:istchrat/screens/consultation_screen/audio_consultation/repo/audio_consultation_repo.dart';


class AudioConsultationCubit extends Cubit<AudioConsultationStates>{

  AudioConsultationCubit() : super(AudioConsultationInitialStates());

  static AudioConsultationCubit get(context)=> BlocProvider.of(context);

  AudioConsultationRepo audioConsultationRepo = AudioConsultationRepo();
  AudioConsultationModel? audioConsultationModel;
  AudioBookAppointmentModel? audioBookAppointmentModel;
  bool isLoading = false;
  int selectedIndex = 0;
  int timeSelectedIndex = 0;
  int durationSelectedIndex = 0;
  Months? selectedMonth;
  bool isError = false;

  getAudioConsultationData(String month,String period, String day) async {
    try{
      isLoading = true;
      isError = false;
      audioConsultationModel = await audioConsultationRepo.getAudioConsultationData(month: month, period: period, day: day);
      selectedMonth = audioConsultationModel!.data!.months![0];
      isLoading = false;
      emit(GetConsultationDataSuccessfully());
    }
    catch(e){
      print("<<<<<<<<<<<<<>>>>>>>>>>>>>>>>");
      print(e);
      isLoading = false;
      isError = true;
      emit(ConsultationErrorState());

    }
  }

  getVideoConsultationByMonth(String month,String period,Months monthValue) async {
    try{
      // isLoading = true;
      audioConsultationModel = await audioConsultationRepo.getAudioConsultationData(month: month, period: period);
      // selectedMonth = videoConsultationModel!.data!.months![0];
      for(int x =0; x< audioConsultationModel!.data!.months!.length ; x++){
        if(monthValue.key.toString() == audioConsultationModel!.data!.months![x].key.toString()){
          selectedMonth = audioConsultationModel!.data!.months![x];
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
  getVideoConsultationByPeriod(String month,String period,Months monthValue, String day) async {
    try{
      audioConsultationModel = await audioConsultationRepo.getAudioConsultationData(month: month, period: period, day: day);
      for(int x =0; x< audioConsultationModel!.data!.months!.length ; x++){
        if(monthValue.key.toString() == audioConsultationModel!.data!.months![x].key.toString()){
          selectedMonth = audioConsultationModel!.data!.months![x];
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

  getDataByDay(String month, String period, String day, Months monthValue) async{
    try{
      audioConsultationModel = await audioConsultationRepo.getAudioConsultationData(month: month, period: period, day: day);
      for(int x =0; x< audioConsultationModel!.data!.months!.length ; x++){
        if(monthValue.key.toString() == audioConsultationModel!.data!.months![x].key.toString()){
          selectedMonth = audioConsultationModel!.data!.months![x];
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

  getAudioBookAppointmentData(String monthKey,String dayKey,String timeKey,String periodKey,String coupon) async{
    try{
      emit(LoadingState());
      audioBookAppointmentModel = await audioConsultationRepo.getAudioBookAppointmentData(
          monthKey,dayKey,timeKey,periodKey,coupon);
      print(audioBookAppointmentModel!.data!.message);
      if(audioBookAppointmentModel!.data!.bookId == null){
        emit(BookAppointmentFailed(audioBookAppointmentModel!.data!.message!));
      }else{
        print(audioBookAppointmentModel!.data!.bookId);
        emit(BookAppointmentSuccessfully(audioBookAppointmentModel!.data!.bookId.toString()));
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