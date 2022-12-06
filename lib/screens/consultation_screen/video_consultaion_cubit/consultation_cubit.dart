import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:istchrat/screens/consultation_screen/consultation_model/VideoBookAppointment.dart';
import 'package:istchrat/screens/consultation_screen/consultation_model/VideoConsultationModel.dart';
import 'package:istchrat/screens/consultation_screen/consultation_repo/consultation_repo.dart';
import 'package:istchrat/screens/consultation_screen/video_consultaion_cubit/consultation_states.dart';

class VideoConsultationCubit extends Cubit<VideoConsultationStates>{

  VideoConsultationCubit() : super(VideoConsultationInitialStates());

  static VideoConsultationCubit get(context)=> BlocProvider.of(context);

  VideoConsultationRepo videoConsultationRepo = VideoConsultationRepo();
  VideoConsultationModel? videoConsultationModel;
  VideoBookAppointmentModel? videoBookAppointmentModel;
  bool isLoading = false;
  int selectedIndex = 0;
  int timeSelectedIndex = 0;
  int durationSelectedIndex = 0;
  Months? selectedMonth;
  bool isError = false;


  getVideoConsultationData(String month,String period) async {
    try{
      isError = false;
      isLoading = true;
      videoConsultationModel = await videoConsultationRepo.getVideoConsultationData(month: month, period: period);
      selectedMonth = videoConsultationModel!.data!.months![0];
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

  getVideoConsultationByMonth(String month,String period,Months monthValue) async {
    try{
      // isLoading = true;
      videoConsultationModel = await videoConsultationRepo.getVideoConsultationData(month: month, period: period);
      // selectedMonth = videoConsultationModel!.data!.months![0];
      for(int x =0; x< videoConsultationModel!.data!.months!.length ; x++){
        if(monthValue.key.toString() == videoConsultationModel!.data!.months![x].key.toString()){
          selectedMonth = videoConsultationModel!.data!.months![x];
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
      videoConsultationModel = await videoConsultationRepo.getVideoConsultationData(month: month, period: period, day: day);
      for(int x =0; x< videoConsultationModel!.data!.months!.length ; x++){
        if(monthValue.key.toString() == videoConsultationModel!.data!.months![x].key.toString()){
          selectedMonth = videoConsultationModel!.data!.months![x];
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

  getDataByDay(String month,String period,Months monthValue, String day) async{
    try{
      videoConsultationModel = await videoConsultationRepo.getVideoConsultationData(month: month, period: period, day: day);
      for(int x =0; x< videoConsultationModel!.data!.months!.length ; x++){
        if(monthValue.key.toString() == videoConsultationModel!.data!.months![x].key.toString()){
          selectedMonth = videoConsultationModel!.data!.months![x];
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

  getVideoBookAppointmentData(String monthKey,String dayKey,String timeKey,String periodKey,String coupon) async {
    try{
      emit(LoadingState());
      videoBookAppointmentModel = await videoConsultationRepo.getVideoBookAppointmentData(
          monthKey,dayKey,timeKey,periodKey,coupon);
      print("<<<<<<<<<<<<<>>>>>>>>>>>>>");
      print(videoBookAppointmentModel!.data!.message);
      if(videoBookAppointmentModel!.data!.bookId == null){
        emit(BookAppointmentFailed(videoBookAppointmentModel!.data!.message!));
      }else{
        print(videoBookAppointmentModel!.data!.bookId);
        emit(BookAppointmentSuccessfully(videoBookAppointmentModel!.data!.bookId.toString()));
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
    print("DDDDDDDDDDDDD");
    print(selectedMonth!.value);
    emit(CheckSelectedMonth(selectedMonth!));
  }

}