import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:istchrat/screens/bottom_nav_bar/my_library_screen/cubit/myLibrary_states.dart';
import 'package:istchrat/screens/bottom_nav_bar/my_library_screen/repository/myLibrary_repository.dart';
import 'package:istchrat/screens/bottom_nav_bar/my_library_screen/repository/model/OldConsultationDataModel.dart';

import '../../../../main.dart';
import '../../../../shared_components/constants/constants.dart';

class MyLibraryCubit extends Cubit<MyLibraryStates> {
  MyLibraryCubit() : super(MyLibraryInitialState());
  static MyLibraryCubit get(BuildContext context) => BlocProvider.of<MyLibraryCubit>(context);

  final MyLibraryRepository _repository = MyLibraryRepository();
  final bool isLogged = box.read(Constants.accessToken.toString()) != null;
  List<Rows>? videoData;
  List<Rows>? audioData;
  List<Rows>? chatData;
  List<Rows>? faqsData;
  List<Rows>? appointmentData;
  List<Rows>? emergencyData;

  Future getVideoConsultations() async{
    if(isLogged){
      emit(MyLibraryVideoLoadingState());
      final response = await _repository.getData("videoConsultations");
      response.fold((error){
        emit(MyLibraryVideoErrorState(error));
      }, (data){
        videoData = data.data?.rows;
        emit(MyLibraryVideoSuccessState(data));
      });
    }
  }

  Future getAudioConsultations() async{
    if(isLogged){
      emit(MyLibraryAudioLoadingState());
      final response = await _repository.getData("voiceConsultations");
      response.fold((error){
        emit(MyLibraryAudioErrorState(error));
      }, (data){
        audioData = data.data?.rows;
        emit(MyLibraryAudioSuccessState(data));
      });
    }
  }

  Future getChatConsultations() async{
    if(isLogged){
      emit(MyLibraryChatLoadingState());
      final response = await _repository.getData("chatConsultations");
      response.fold((error){
        emit(MyLibraryChatErrorState(error));
      }, (data){
        chatData = data.data?.rows;
        emit(MyLibraryChatSuccessState(data));
      });
    }
  }

  Future getFaqsConsultations() async{
    if(isLogged){
      emit(MyLibraryFaqsLoadingState());
      final response = await _repository.getData("faqs");
      response.fold((error){
        emit(MyLibraryFaqsErrorState(error));
      }, (data){
        faqsData = data.data?.rows;
        emit(MyLibraryFaqsSuccessState(data));
      });
    }
  }

  Future getAppointmentConsultations() async{
    if(isLogged){
      emit(MyLibraryAppointmentLoadingState());
      final response = await _repository.getData("appointmentConsultations");
      response.fold((error){
        emit(MyLibraryAppointmentErrorState(error));
      }, (data){
        appointmentData = data.data?.rows;
        emit(MyLibraryAppointmentSuccessState(data));
      });
    }
  }

  Future getEmergencyConsultations() async{
    if(isLogged){
      emit(MyLibraryEmergencyLoadingState());
      final response = await _repository.getData("emergencyConsultations");
      response.fold((error){
        emit(MyLibraryEmergencyErrorState(error));
      }, (data){
        emergencyData = data.data?.rows;
        emit(MyLibraryEmergencySuccessState(data));
      });
    }
  }

}