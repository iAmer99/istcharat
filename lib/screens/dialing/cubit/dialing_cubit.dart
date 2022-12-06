import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:istchrat/screens/dialing/cubit/dialing_states.dart';
import 'package:istchrat/screens/dialing/repository/dialing_repository.dart';

class DialingCubit extends Cubit<DialingStates> {
  DialingCubit() : super(DialingInitialState());

  static DialingCubit get(BuildContext context) =>
      BlocProvider.of<DialingCubit>(context);

  final DialingRepository _repository = DialingRepository();
  String channelName = "";
  String img = "";

  Future startCall(
      {required String id,
      required String key,
      required bool isLecturer}) async {
    if (isLecturer) {
      emit(DialingCallStartingState());
      final response = await _repository.startCall(id: id, key: key);
      response.fold((error) {
        emit(DialingCallFailedState(error));
      }, (model) {
        channelName = model.data?.channel?.channelName ?? "";
        img = model.data?.channel?.reciverImage ?? "";
        emit(DialingCallStartedState());
      });
    }
  }

  Future endCall({
    required String id,
    required String key,
  }) async {
    final response = await _repository.endCall(id: id, key: key);
    if(response){
      emit(DialingCallEndedState());
    }
  }

  Future acceptOrCancel(
      {required String id, required String key, required String status}) async {
    final response =
        await _repository.acceptOrCancel(id: id, key: key, status: status);
    if (response) {
      if (status == "accept") {
        emit(DialingAcceptedState());
      } else {
        emit(DialingRejectedState());
      }
    }
  }
}
